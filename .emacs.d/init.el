;; Move customization variables to a separate file and load it
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; Set the right directory to store the native comp cache
(add-to-list 'native-comp-eln-load-path
	     (expand-file-name "eln-cache/" user-emacs-directory))

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(use-package emacs
  :ensure nil
  :hook (dired-mode . auto-revert-mode)
  :custom
  (make-backup-files nil)
  (inhibit-startup-message t)
  (visible-bell t)
  (native-comp-async-report-warnings-errors nil)
  :config
  ;; Visual Minor Modes
  (menu-bar-mode 0)
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  (global-display-line-numbers-mode 1)
  (global-hl-line-mode 1)

  ;; Functional Minor Modes
  (ido-mode 1)
  ;; Revert buffers when the underlying file has changed
  (global-auto-revert-mode 1))

(use-package moe-theme
  :ensure t
  :config (load-theme 'moe-dark t))

