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
;; Create a variable to store the path to this dotfile directory
;; (Usually ~/.emacs.d)
(setq dotfiles-dir (file-name-directory
		    (or (buffer-file-name) load-file-name)))

;; Create variables to store the path to this dotfile dir's lib etc and tmp directories
;; (setq dotfiles-settings-dir (concat dotfiles-dir "settings/"))
;; (setq dotfiles-init-dir (concat dotfiles-dir "packages"))
;; (setq dotfiles-tmp-dir (concat dotfiles-dir "tmp/"))
;; 
;; Create helper functions for loading dotfile paths and files
(defun add-dotfile-path (p)
  (add-to-list 'load-path (concat dotfiles-dir p)))

(defun load-dotfile (f)
  (load-file (concat dotfiles-dir f)))

;; Ensure the necessary directories is on the load path
(add-dotfile-path "settings/")
(add-dotfile-path "packages/")
(add-dotfile-path "lib/")
;; load packages inits
(load-dotfile "packages/init-evil.el")
(load-dotfile "packages/init-key-chord.el")
(load-dotfile "packages/init-neotree.el")
(load-dotfile "packages/init-projectile.el")
(load-dotfile "packages/init-flycheck.el")
(load-dotfile "packages/init-nerd-commenter.el")
(load-dotfile "packages/init-smartparens.el")
(load-dotfile "packages/init-multiple-cursors.el")
(load-dotfile "packages/init-magit.el")
(load-dotfile "packages/init-git-gutter.el")
(load-dotfile "packages/init-yasnippet.el")
(load-dotfile "packages/init-company.el")
;; (load-dotfile "packages/init-helm.el")
(load-dotfile "packages/init-powerline.el")
;; (load-dotfile "packages/init-sml.el")

;; Programming
(load-file "settings/init-ruby.el")

;; Load custom libs
(load-dotfile "lib/ido-other-window.el") ;; Open from IDO to slit window

;; Load settings
(load-dotfile "settings/global.el")
(load-dotfile "settings/ui.el")
(load-dotfile "settings/init-ido.el")
(load-dotfile "settings/init-smex.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
	 [default default default italic underline success warning error])
 '(ansi-color-names-vector
	 ["#ecf0f1" "#e74c3c" "#2ecc71" "#f1c40f" "#2492db" "#9b59b6" "#1abc9c" "#2c3e50"])
 '(custom-safe-themes
	 (quote
		("f77b6707a80f56162f03bfdfddca6655a0fe772a46342daa6628621fb4cfa682" "26614652a4b3515b4bbbb9828d71e206cc249b67c9142c06239ed3418eff95e2" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "9122dfb203945f6e84b0de66d11a97de6c9edf28b3b5db772472e4beccc6b3c5" "0ba649556dc51762e6794b92017f6f7406754ae3136eafef686d81c6da176cc5" "9b41f298ad28dc56765b227e4b9ed38f98a236706a3a26b148491a0dade90568" default)))
 '(fci-rule-color "#f1c40f")
 '(helm-descbinds-mode t)
 '(hl-paren-background-colors (quote ("#2492db" "#95a5a6" nil)))
 '(hl-paren-colors (quote ("#ecf0f1" "#ecf0f1" "#c0392b")))
 '(vc-annotate-background "#ecf0f1")
 '(vc-annotate-color-map
	 (quote
		((30 . "#e74c3c")
		 (60 . "#c0392b")
		 (90 . "#e67e22")
		 (120 . "#d35400")
		 (150 . "#f1c40f")
		 (180 . "#d98c10")
		 (210 . "#2ecc71")
		 (240 . "#27ae60")
		 (270 . "#1abc9c")
		 (300 . "#16a085")
		 (330 . "#2492db")
		 (360 . "#0a74b9"))))
 '(vc-annotate-very-old-color "#0a74b9"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
 
