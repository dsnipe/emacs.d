;;; ui.el --- Interface settings
;;; Commentary: 
;;; Code: 

;; Themes and theme customizations
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(if window-system
    (load-theme 'Amelie t)
  (load-theme 'monokai t))
;; (set-face-attribute 'default nil :background "unspecific-bg"))

;; Setup my favorite fonts
(set-face-attribute 'default nil :family "Source Code Pro" :height 150 :weight 'normal)
(setq mac-allow-anti-aliasing nil)  ;; turn off anti-aliasing
;;(set-face-attribute 'helm-candidate-number nil :background "#2875d7" :foreground "#fff")
;;
;; remember the cursor position of files when reopening them
(setq save-place-file "~/.emacs.d/tmp/saveplace")
(setq-default save-place t)

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
 
;; Not toolbar and menu-bar
(when (functionp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (functionp 'menu-bar-mode)
  (menu-bar-mode -1))
(when (functionp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; show the column number in the status bar
(column-number-mode t)
;; Highlight cursor line
(global-hl-line-mode t)

(setq blink-cursor-mode nil)
;; Make lines longer than 80 highlighted
(setq whitespace-line-column 120) ;; limit line length
(setq whitespace-style '(face lines-tail))
;; (setq whitespace-style '(tabs newline space-mark
;;                          tab-mark newline-mark
;;                          face lines-tail))
;; (setq whitespace-display-mappings
;;       ;; all numbers are Unicode codepoint in decimal. e.g. (insert-char 182 1)
;;       ;; 32 SPACE, 183 MIDDLE DOT
;;       '((space-mark nil)
;;         ;; 10 LINE FEED
;;         ;;(newline-mark 10 [172 10])
;;         (newline-mark nil)
;;         ;; 9 TAB, MIDDLE DOT
;;         (tab-mark 9 [183 9] [92 9])))
;; (setq whitespace-global-modes '(not org-mode
;;                                     eshell-mode
;;                                     shell-mode
;;                                     web-mode
;;                                     log4j-mode
;;                                     "Web"
;;                                     dired-mode
;;                                     emacs-lisp-mode
;;                                     clojure-mode
;;                                     lisp-mode))
(global-whitespace-mode t)
(diminish 'global-whitespace-mode "")

(set-default 'indicate-empty-lines t)
(setq show-trailing-whitespace t)

(add-hook 'prog-mode-hook 'whitespace-mode)

(use-package highlight-thing
	:init
	(defface highlight-thing
		'((t (:background "#696969")))
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
;; set bar cursor for evil-emacs mode
(setq evil-emacs-state-cursor '(bar))

;; activate color madnes in code
(add-hook 'after-init-hook 'global-color-identifiers-mode)

;; Mode line
(use-package powerline
	:config
	(progn
		;; (powerline-center-evil-theme)
	  (require 'powerline-dmt-theme)
		(powerline-dmt-theme)
		(setq powerline-default-separator 'wave) 
		(setq powerline-arrow-shape 'wave)
		;; (powerline-evil-vim-color-theme)
		(setq display-time-24hr-format t)
		(display-time-mode t)))

(setq ns-use-srgb-colorspace t)  ;; move to global
