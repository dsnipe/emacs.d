;; Global settings
(setq-default tab-width 2)
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

;; Startup screen
(setq-default inhibit-startup-buffer-menu nil
              inhibit-startup-screen        t
              initial-buffer-choice       nil
              initial-scratch-message     nil
              initial-major-mode          'fundamental-mode)

;; Enable save sessions
(setq desktop-save-mode 1)

;; Show and create matching parens automaticaly
(show-paren-mode t)
(use-package popwin
  :config
    (popwin-mode t))

(use-package zoom-window
	:config
	(define-prefix-command 'ctrl-w-map)
	(global-set-key (kbd "C-w") 'ctrl-w-map)
	(define-key ctrl-w-map (kbd "z") 'zoom-window-zoom))

;; Not toolbar and menu-bar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(fset 'yes-or-no-p 'y-or-n-p)

;; Fix problem with zsh
(setq system-uses-terminfo nil)
(add-hook 'term-mode-hook (lambda()
        (setq yas-dont-activate t)))
(add-hook 'term-mode-hook (lambda()
                (yas-minor-mode -1)))
(add-hook 'term-mode-hook (lambda()
														(company-mode -1)))
;; Set locales
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Copy/Paste from OSX 
(defun copy-from-osx ()
	(shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
	(let ((process-connection-type nil))
		(let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
			(process-send-string proc text)
			(process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

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

(defun switch-to-minibuffer-window ()
  "switch to minibuffer window (if active)"
  (interactive)
  (when (active-minibuffer-window)
    (select-window (active-minibuffer-window))))
(global-set-key (kbd "<f7>") 'switch-to-minibuffer-window)
