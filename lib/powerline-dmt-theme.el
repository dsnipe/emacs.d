;;; Powerline DmT theme
;; Commentary:
;; (list (funcall separator-left mode-line face0))
;; 
;; Code:

(defface powerline-active0 '((t (:foreground "#005fff" :weight bold :background "color-235" :inherit mode-line)))
	"Powerline face 0."
	:group 'powerine)
(defface powerline-inactive0 '((t (:background nil :weight bold :inherit modeline-inactive)))
	"Powerline face 0."
	:group 'powerline)
(defface pw-active1 '((t (:foreground "white" :background "grey22" :inherit mode-line)))
	"Custom powerline active1 face"
	:group 'powerine)
(defface pw-inactive1 '((t (:background "grey11" :inherit mode-line)))
	"Custom powerline active1 face"
	:group 'powerine)
(defface pw-active2 '((t (:foreground "color-234" :background "grey40" :inherit mode-line)))
	"Custom powerline active1 face"
	:group 'powerine)
(defface pw-active2 '((t (:background "grey20" :inherit mode-line)))
	"Custom powerline active1 face"
	:group 'powerine)
(defface powerline-evil-base-face '((t (:foreground "#1c1c1c")))
  "Powerline evil base customization"
  :group 'powerline)

(require 'powerline-evil)
;; DmT Powerline theme
;; 																		 (when (and (boundp 'which-func-mode) which-func-mode)
;; 																			 (powerline-raw which-func-format face0 'l))
;; 																		 (powerline-narrow face0 'l)
;; 																		 (funcall separator-left face0 face1)
;; 																		 (when (boundp 'erc-modified-channels-object)
;; 																			 (powerline-raw erc-modified-channels-object face1 'l))
;; 																		 (powerline-process face1)

(setq powerline-default-separator 'wave)
(defun powerline-dmt-theme ()
  "Setup a mode-line with major, evil, and minor modes centered."
  (interactive)
  (setq-default mode-line-format
		'("%e"
		  (:eval
		   (let* ((active (powerline-selected-window-active))
			  (mode-line (if active 'mode-line 'mode-line-inactive))
				(face0 (if active 'powerline-active0 'powerline-inactive0))
			  (face1 (if active 'pw-active1 'pw-inactive1))
			  (face2 (if active 'pw-active2 'pw-inactive2))
			  (separator-left (intern (format "powerline-%s-%s"
							  (powerline-current-separator)
							  (car powerline-default-separator-dir))))
			  (separator-right (intern (format "powerline-%s-%s"
						   (powerline-current-separator)
							   (cdr powerline-default-separator-dir))))
			  (lhs (append
							(if evil-mode
								(list 
										(powerline-raw (powerline-evil-tag) (powerline-evil-face))
										(funcall separator-left (powerline-evil-face) face1))
								(list ()))
							(list
							 (powerline-buffer-id face1 'l)
							 (powerline-raw "%*" face1 'l)
						   (powerline-raw " " face1)
							 (powerline-narrow face1)
							 (funcall separator-left face1 face2)
							 (powerline-vc face2)
							 (funcall separator-left face2 face0))))
			  (rhs (list
					 (funcall separator-right face0 face2)
						 (powerline-major-mode face2 'l)
				     (powerline-raw " " face2)
				     ;; (funcall separator-right face1 face0)
						 ;; (powerline-minor-modes face0 'r)
						 (funcall separator-right face2 face1)
						 (powerline-raw " " face1)
						 (powerline-raw global-mode-string face1)
				     (powerline-hud face1 face0))))
				(concat (powerline-render lhs)
			     (powerline-fill face0 (powerline-width rhs))
			     (powerline-render rhs)))))))

(provide 'powerline-dmt-theme)
