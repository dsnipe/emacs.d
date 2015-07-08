;; =============================================================================
;; ui
;; =============================================================================
;; Add /themes directory for storing custom themes
;; Themes and theme customizations
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;; (load-theme 'nice t)
(load-theme 'monokai t)

;; (unless window-system
		;; (set-face-attribute 'default nil :background "unspecific-bg"))

;; Setup my favorite fonts
(set-face-attribute 'default nil :family "Source Code Pro" :height 150 :weight 'normal)
(setq mac-allow-anti-aliasing nil)  ;; turn off anti-aliasing
;;(set-face-attribute 'helm-candidate-number nil :background "#2875d7" :foreground "#fff")

(global-linum-mode t)
(setq-default truncate-lines t)
;; (use-package hlinum
;; 	:config
;; 	(hlinum-activate))
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

(setq blink-cursor-mode nil)
;; Make lines longer than 80 highlighted
(setq whitespace-line-column 120) ;; limit line length
(setq whitespace-style '(face lines-tail))
(global-whitespace-mode t)

(add-hook 'prog-mode-hook 'whitespace-mode)

(use-package highlight-thing
	:init
	(defface highlight-thing
		'((t (:background "color-236")))
		"Face that is used to highlight things."
		:group 'highlight-thing)
	:config
	(global-highlight-thing-mode 1))

;; make smooth scrolling
(require 'smooth-scrolling)
(setq smooth-scroll-margin 3)
;; Delay updates to give Emacs a chance for other changes
(setq linum-delay t)
(setq redisplay-dont-pause t)

(use-package golden-ratio
	:config
	(golden-ratio-mode 1)
	(add-to-list 'golden-ratio-exclude-buffer-names " *NeoTree*"))

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

