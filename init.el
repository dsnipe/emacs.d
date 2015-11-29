;;; init.el --- main config file
;;; Commentary:
;;; Code:

;; Package Manager
(require 'cask "/usr/local/share/emacs/site-lisp/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

;; Init user-package
(eval-when-compile
	(require 'use-package))
(require 'diminish)
(require 'bind-key)

;; Load path helper function
(defun add-subdirs-to-list (list base-path)
  (let ((base-dir (file-name-as-directory base-path)))
    (dolist (filename (directory-files base-dir))
      (let ((path (concat base-dir filename)))
        (when (and (file-directory-p path)
                   (not (string= filename "."))
                   (not (string= filename "..")))
          (add-to-list list path))))))
;; Create a variable to store the path to this dotfile directory
(setq dotfiles-dir (file-name-directory
		    (or (buffer-file-name) load-file-name)))
;; Create helper functions for loading dotfile paths and files
(defun add-dotfile-path (p)
  (add-to-list 'load-path (concat dotfiles-dir p)))
(defun load-dotfile (f)
  (load-file (concat dotfiles-dir f)))

;; Ensure the necessary directories is on the load path
;; (add-dotfile-path "settings/")
(add-dotfile-path "lib/")

;; load packages inits
(load-dotfile "settings/evil-mode.el")
(load-dotfile "settings/frontend-prog-modes.el")
(load-dotfile "settings/backend-prog-modes.el")
(load-dotfile "settings/packages.el")
(load-dotfile "settings/prog-mode-packages.el")
(load-dotfile "settings/org-mode.el")
(load-dotfile "settings/ido-smex.el")
(load-dotfile "settings/init-projectile.el")

(load-dotfile "settings/init-yasnippet.el")
(load-dotfile "settings/init-company.el")
;; (load-dotfile "settings/init-helm.el")
(load-dotfile "settings/init-ace-jump.el")
;; Load custom libs
(load-dotfile "lib/ido-other-window.el") ;; Open from IDO to slit window
(load-dotfile "lib/iterm2-spec.el") ;; special key decodes
;; Load settings
(load-dotfile "settings/global.el")
(load-dotfile "settings/ui.el")
;;
;; Load cutom files
(load-dotfile "settings/prodigy_services.el")

(use-package server
  :if window-system
  :config
  (unless (server-running-p)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
	 (quote
		("f77b6707a80f56162f03bfdfddca6655a0fe772a46342daa6628621fb4cfa682" "26614652a4b3515b4bbbb9828d71e206cc249b67c9142c06239ed3418eff95e2" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "9122dfb203945f6e84b0de66d11a97de6c9edf28b3b5db772472e4beccc6b3c5" "0ba649556dc51762e6794b92017f6f7406754ae3136eafef686d81c6da176cc5" "9b41f298ad28dc56765b227e4b9ed38f98a236706a3a26b148491a0dade90568" default)))
 '(fci-rule-color "#f1c40f")
 '(git-gutter:update-interval 2)
 '(helm-descbinds-mode t)
 '(hl-paren-background-colors (quote ("#2492db" "#95a5a6" nil)))
 '(hl-paren-colors (quote ("#ecf0f1" "#ecf0f1" "#c0392b")))
 '(mac-command-modifier (quote meta))
 '(mac-option-modifier (quote meta))
 '(mac-right-command-modifier nil)
 '(mac-text-scale-standard-width 120)
 '(send-mail-function (quote mailclient-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:background "grey75" :foreground "black")))))
(put 'erase-buffer 'disabled nil)
