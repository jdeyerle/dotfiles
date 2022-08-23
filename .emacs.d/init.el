(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(setq user-emacs-directory (expand-file-name "~/.cache/emacs/")
      url-history-file (expand-file-name "url/history" user-emacs-directory))

(use-package no-littering)

(setq custom-file
      (expand-file-name
       (format "emacs-custom-%s.el" (user-uid)) temporary-file-directory))
(load custom-file 'noerror 'nomessage)

(use-package try)

(use-package emacs
  :bind (("C-x C-b" . ibuffer)
         ("C-x C-k" . kill-buffer-and-window))
  :hook
  ;; Auto reload dired buffers when the file system changes
  (dired-mode . auto-revert-mode)
  (prog-mode . visual-line-mode)
  :custom
  (inhibit-startup-message t)
  (visible-bell t)
  (make-backup-files nil)
  :config
  ;; Minor Modes
  (menu-bar-mode 0)
  (tool-bar-mode 0)
  (scroll-bar-mode 0)

  (global-display-line-numbers-mode 1)
  (global-hl-line-mode 1)
  (ido-mode 1)
  (column-number-mode 1)
  (delete-selection-mode 1)

  ;; Revert buffers when the underlying file has changed
  (global-auto-revert-mode 1)

  (setq-default tab-width 2
                indent-tabs-mode nil)

  (if (display-graphic-p)
      (global-unset-key (kbd "C-x C-z"))))

(defun my/find-config ()
  "Opens my emacs config file"
  (interactive)
  (find-file "~/.emacs.d/config.org"))

(defun my/debuff ()
  "Kills buffers that commonly crowd my buffer list"
  (interactive)
  (let* ((regexps '("^magit"
                    "^\\*helpful"
                    "\\*Disabled Command\\*"
                    "\\*Completions\\*"
                    "\\*Backtrace\\*"
                    "\\*Messages\\*"
                    "\\*Ibuffer\\*"
                    "\\*Compile-Log\\*"))
         (regexp (string-join regexps "\\|")))
    (kill-matching-buffers regexp nil 'no-ask)))

(defun my/turn-off-line-numbers ()
  (display-line-numbers-mode -1))

(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-M->" . mc/skip-to-next-like-this)
         ("C-M-<" . mc/skip-to-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package rainbow-mode
  :hook (prog-mode help-mode org-mode))

(use-package whitespace-cleanup-mode
  :config (global-whitespace-cleanup-mode 1))

(use-package spell-fu)

(use-package avy
  :bind (("M-g M-g" . avy-goto-char)
         ("M-g b" . avy-pop-mark)))

(use-package org
  :hook (org-mode . visual-line-mode)
  :custom
  ;; code blocks
  (org-src-preserve-indentation t)
  (org-src-tab-acts-natively t)
  (org-src-fontify-natively t)
  ;; quote blocks
  (org-fontify-quote-and-verse-blocks t)
  ;; org-edit-special (C-c ')
  (org-src-window-setup 'current-window)
  :config
  ;; org-insert-structure-template (C-c C-,)
  (add-to-list 'org-structure-template-alist '("se" . "src emacs-lisp")))

;; BUG: org-collect-keywords not found - use C-c C-v t
;;(use-package org-auto-tangle
;;  :hook (org-mode . org-auto-tangle-mode))

(use-package treemacs
  :custom
  (treemacs-is-never-other-window t)
  (treemacs-width 30)
  :hook (treemacs-mode . my/turn-off-line-numbers)
  :bind (("<f8>" . treemacs)
         ("C-<f8>" . treemacs-select-window))) 

(use-package treemacs-icons-dired
  :after treemacs dired
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after treemacs magit)

(if-let ((browser (getenv "BROWSER")))
    (setq browse-url-generic-program (executable-find browser)
          browse-url-browser-function 'browse-url-generic))

(use-package magit)

(use-package request)
(use-package restclient)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package company
  :hook ((cider-repl-mode
          clojure-mode
          emacs-lisp-mode
          ielm-mode) . company-mode))

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(use-package term
  :hook (term-mode . my/turn-off-line-numbers))

(use-package vterm
  :commands vterm
  :hook (vterm-mode . my/turn-off-line-numbers))

(use-package eshell
  :hook ((eshell-mode . my/turn-off-line-numbers)
         (eshell-pre-command . eshell-save-some-history))
  :custom
  (eshell-history-size 10000)
  (eshell-buffer-maximum-lines 10000)
  (eshell-hist-ignoredups t))

(use-package eshell-git-prompt
  :config
  (eshell-git-prompt-use-theme 'multiline2))

;; (use-package parinfer-rust-mode
;;   :custom (parinfer-rust-auto-download t)
;;   :hook (emacs-lisp-mode clojure-mode))
(use-package paredit
  :init
  (add-hook 'emacs-lisp-mode-hook 'paredit-mode)
  (add-hook 'clojure-mode-hook 'paredit-mode)
  (add-hook 'cider-repl-mode-hook 'paredit-mode))

(use-package clojure-mode)
(use-package cider
  :hook (cider-repl-mode . my/turn-off-line-numbers))

(add-hook 'emacs-lisp-mode-hook 'company-mode)
(add-hook 'ielm-mode-hook 'my/turn-off-line-numbers)

(use-package helpful
  :bind (("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h o" . helpful-symbol)
         ("C-h C" . helpful-command)
         ("C-c C-d" . helpful-at-point)))

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)))
  ;;:custom (markdown-command "multimarkdown"))

(use-package flymake-shellcheck
  :commands flymake-shellcheck-load
  :init (add-hook 'sh-mode-hook 'flymake-shellcheck-load))

;; set tab width
(setq sh-basic-offset 2)

(use-package doom-themes
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  (doom-themes-treemacs-theme "doom-colors")
  :config
  (load-theme 'doom-material-dark t)

  (doom-themes-visual-bell-config)
  (doom-themes-org-config)
  (doom-themes-treemacs-config))

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package all-the-icons
  :if (display-graphic-p))
