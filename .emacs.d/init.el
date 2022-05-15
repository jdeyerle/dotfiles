;; -*- lexical-binding: t -*-

;; Org is required for org-babel-tangle-file
(require 'org)

;; Bootstrap Emacs
(let* ((this-file (or load-file-name buffer-file-name))
       (this-dir (file-name-directory this-file))
       (config-file-org (concat this-dir "config.org"))
       (tangled-config-file (car (org-babel-tangle-file config-file-org))))

  (defun my/find-config ()
    "Opens my emacs config file"
    (interactive)
    (find-file config-file-org))

  (load-file tangled-config-file))
