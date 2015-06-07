;; =============================================================================
;; ui
;; =============================================================================
;; Add /themes directory for storing custom themes
;; Themes and theme customizations
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'nice t)

(unless window-system
		(set-face-attribute 'default nil :background "unspecific-bg"))

(defface mode-line '((t (:background "grey75" :foreground "dark gray")))
	"Default custom Mode line colors"
	:group 'mode-line)
;; Setup my favorite fonts
(set-face-attribute 'default nil :family "Source Code Pro" :height 150)

;;(set-face-attribute 'helm-candidate-number nil :background "#2875d7" :foreground "#fff")

(global-linum-mode t)
(setq-default truncate-lines t)
(use-package hlinum
	:config
	(hlinum-activate))
(defun linum-format-func (line)
	(let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
		(propertize (format (format "%%%dd " w) line) 'face 'linum)))
(setq linum-format 'linum-format-func)
;; use customized linum-format: add a addition space after the line number

;; remember the cursor position of files when reopening them
(setq save-place-file "~/.emacs.d/tmp/saveplace")
(setq-default save-place t)

;; show the column number in the status bar
(column-number-mode t)
;; Highlight cursor line
(global-hl-line-mode t)

;; Make lines longer than 80 highlighted
(setq whitespace-line-column 120) ;; limit line length
(setq whitespace-style '(face lines-tail))
(global-whitespace-mode t)

(add-hook 'prog-mode-hook 'whitespace-mode)

;; Fix cursor for Evil mode
(defun my-send-string-to-terminal (string)
	(unless (display-graphic-p) (send-string-to-terminal string)))

(defun my-evil-terminal-cursor-change ()
	(when (string= (getenv "TERM_PROGRAM") "iTerm.app")
		(add-hook 'evil-insert-state-entry-hook (lambda () (my-send-string-to-terminal "\e]50;CursorShape=1\x7")))
		(add-hook 'evil-insert-state-exit-hook  (lambda () (my-send-string-to-terminal "\e]50;CursorShape=0\x7"))))
	(when (and (getenv "TMUX") (string= (getenv "TERM_PROGRAM") "iTerm.app"))
		(add-hook 'evil-insert-state-entry-hook (lambda () (my-send-string-to-terminal "\ePtmux;\e\e]50;CursorShape=1\x7\e\\")))
		(add-hook 'evil-insert-state-exit-hook  (lambda () (my-send-string-to-terminal "\ePtmux;\e\e]50;CursorShape=0\x7\e\\")))))

(add-hook 'after-make-frame-functions (lambda (frame) (my-evil-terminal-cursor-change)))
(my-evil-terminal-cursor-change)

