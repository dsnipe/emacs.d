(setq-default make-backup-files nil
              tab-width 2)

;;(setq line-number-mode t)
(setq scroll-step 5
      scroll-conservatively 9999
      scroll-margin 5
      make-pointer-invisible t
      frame-title-format "%b@Emacs"
      enable-local-eval t
      ring-bell-function 'ignore)

;; Backup settings
(setq version-control t
			kept-new-versions 5
			kept-old-versions 0
			delete-old-versions t)
(setq backup-directory-alist '(("". "~/.emacs.d/.backups" )))

;; Cturtup screen
(setq-default inhibit-startup-buffer-menu nil
              inhibit-startup-screen        t
              initial-buffer-choice       nil
              initial-scratch-message     nil
              initial-major-mode          'fundamental-mode)

;; Enable save sessions
(setq desktop-save-mode 1)

;; Show and create matching parens automaticaly
(show-paren-mode t)

;; Not toolbar and menu-bar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(fset 'yes-or-no-p 'y-or-n-p)

;; mac specific settings
(when (eq system-type 'darwin) 
;; (setq mac-option-modifier 'alt)
	;; (setq mac-command-modifier 'meta)
	(global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
	)

(unless window-system
	(setq mac-command-modifier 'meta))
(setq ns-function-modifier 'super)

;; Enable mouse in terminal
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] '(lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
                              (interactive)
                              (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
)


