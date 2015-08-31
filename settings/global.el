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

;; Store autosave files in system temp
(setq backup-directory-alist
			`((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
				`((".*" ,temporary-file-directory t)))
(setq create-lockfiles nil) ;; disable lockfile .#<filename>

;; Startup screen
(setq-default inhibit-startup-buffer-menu nil
              inhibit-startup-screen        t
              initial-buffer-choice       nil
              initial-scratch-message     nil
              initial-major-mode          'fundamental-mode)
																				;

;; ENABLE save sessions
(setq desktop-save-mode 1)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; I want underscores as part of word in all modes
(modify-syntax-entry (string-to-char "_") "w" (standard-syntax-table))
(modify-syntax-entry (string-to-char "_") "w" text-mode-syntax-table)
(modify-syntax-entry (string-to-char "_") "w" lisp-mode-syntax-table)
(modify-syntax-entry (string-to-char "_") "w" emacs-lisp-mode-syntax-table)
;; Not builtin modes
(modify-syntax-entry (string-to-char "_") "w" ruby-mode-syntax-table)
(modify-syntax-entry (string-to-char "_") "w" elixir-mode-syntax-table)
;; (modify-syntax-entry (string-to-char "_") "w" coffee-mode-syntax-table)
 
;; Not toolbar and menu-bar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(fset 'yes-or-no-p 'y-or-n-p)

(defadvice save-buffer (before save-buffer-always activate)
  "always save buffer"
  (set-buffer-modified-p t))

;; For dired-mode neccessary `brew install coreutils'
(setq ls-lisp-use-insert-directory-program t) 
;; (setq insert-directory-program "gls") 

(defun new-above-line ()
	"Move to line above current"
	(interactive)
	(beginning-of-line)
	(new-line-and-indent))

(defun new-line-without-break ()
	"Move to end of line and insert new line"
	(interactive)
	(let ((oldpos (point)))
		(end-of-line)
		(comment-indent-new-line)))

(global-set-key (kbd "M-RET") 'new-line-without-break)
(global-set-key (kbd "M-S-RET") 'new-above-line) ;; not work in terminal

;; Fix problem with zsh, disbale company and yas in terminal
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
  (setq mouse-sel-mode t))


;;;;;;;;;;;;;;
;; Packages ;;
;;;;;;;;;;;;;;

(use-package smart-tab
	:config
	(global-smart-tab-mode 1))


(use-package move-text
	:bind
	(("M-S-<up>" . move-text-up)
	 ("M-S-<down>" . move-text-down)))

;; Show and create matching parens automaticaly
;; (show-paren-mode t)
;; (use-package popwin
;;   :config
;;     (popwin-mode t))

(use-package zoom-window
	:config
	(define-prefix-command 'ctrl-w-map)
	(global-set-key (kbd "C-w") 'ctrl-w-map)
	(define-key ctrl-w-map (kbd "z") 'zoom-window-zoom))

(global-set-key (kbd "M-s") 'save-buffer) ;; OSx style save
 
(use-package yaml-mode
	:config
	(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode)))

(use-package expand-region
	:config (global-set-key (kbd "C-=") 'er/expand-region))

