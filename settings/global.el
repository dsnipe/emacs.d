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
              initial-buffer-choice         t
              initial-scratch-message     nil
              initial-major-mode          'fundamental-mode)

;; ENABLE save sessions
(setq desktop-save-mode 1)

(setq-default indent-tabs-mode nil)


;; Extract shell envs
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
 
(fset 'yes-or-no-p 'y-or-n-p)

(global-auto-revert-mode t)
(setq auto-revert-verbose nil)

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
	(default-indent-new-line)
  (forward-line -1))

(defun new-line-without-break ()
	"Move to end of line and insert new line"
	(interactive)
	(let ((oldpos (point)))
		(end-of-line)
		(default-indent-new-line)))

(global-set-key (kbd "M-S-<return>") 'new-above-line) ;; not work in terminal
(global-set-key (kbd "M-<return>") 'new-line-without-break)

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

;; mac specific settings
(when (eq system-type 'darwin) 
;; (setq mac-option-modifier 'alt)
	;; (setq mac-command-modifier 'meta)
	(global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
	)

;; (unless window-system
;; 	(setq mac-command-modifier 'meta))

(setq ns-function-modifier 'super)

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

(global-set-key (kbd "M-s") 'save-buffer) ;; OSx style save

;; Check spell
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(eval-after-load 'dired
  ;; Create file in Dired, using _
  '(progn
     (define-key dired-mode-map (kbd "_") 'my-dired-create-file)
     (defun my-dired-create-file (file)
       "Create a file called FILE.
If FILE already exists, signal an error."
       (interactive
        (list (read-file-name "Create file: " (dired-current-directory))))
       (let* ((expanded (expand-file-name file))
              (try expanded)
              (dir (directory-file-name (file-name-directory expanded)))
              new)
         (if (file-exists-p expanded)
             (error "Cannot create file %s: file exists" expanded))
         ;; Find the topmost nonexistent parent dir (variable `new')
         (while (and try (not (file-exists-p try)) (not (equal new try)))
           (setq new try
                 try (directory-file-name (file-name-directory try))))
         (when (not (file-exists-p dir))
           (make-directory dir t))
         (write-region "" nil expanded t)
         (when new
           (dired-add-file new)
           (dired-move-to-filename))))))


