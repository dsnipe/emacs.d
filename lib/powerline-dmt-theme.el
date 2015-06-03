;;; Powerline DmT theme
;; Commentary:

;; Code:
;; (require 'powerline-evil)

(defface powerline-active0 '((t (:foreground "#005fff" :weight bold :background "#262626" :inherit mode-line)))
	"Powerline face 0."
	:group 'powerine)
(defface powerline-inactive0 '((t (:background nil :weight bold :inherit modeline-inactive)))
	"Powerline face 0."
	:group 'powerline)
(defface powerline-active1 '((t (:foreground "#005fff")))
	"Custom powerline active1 face"
	:group 'powerine)
(defface powerline-active2 '((t (:foreground "#005fff")))
	"Custom powerline active1 face"
	:group 'powerine)

(defface powerline-evil-base-face '((t (:foreground "#1c1c1c")))
  "Powerline evil base customization"
  :group 'powerline)

;; DmT Powerline theme
;; 													(lhs (list (powerline-raw "%*" face0 'l)
;; 																		 (powerline-buffer-id face0 'l)
;; 																		 (when (and (boundp 'which-func-mode) which-func-mode)
;; 																			 (powerline-raw which-func-format face0 'l))
;; 																		 (powerline-narrow face0 'l)
;; 																		 (funcall separator-left face0 face1)
;; 																		 (when (boundp 'erc-modified-channels-object)
;; 																			 (powerline-raw erc-modified-channels-object face1 'l))
;; 																		 (powerline-major-mode face1 'l)
;; 																		 (powerline-process face1)
;; 																		 (powerline-raw " " face1 'r)
;; 																		 (powerline-minor-modes face1 'l)
;; 																		 (powerline-narrow face1)
;; 																		 (funcall separator-left face1 face2)
;; 																		 (powerline-vc face2 'r)))
;; 													(rhs (list (powerline-raw global-mode-string face2 'r)
;; 																		 (funcall separator-right face2 face1)
;; 																		 (powerline-raw "%l" face1)
;; 																		 (powerline-raw ":" face1)
;; 																		 (powerline-raw "%c" face1)
;; 																		 (funcall separator-right face1 face0)
;; 																		 (powerline-raw "%p" face0)
;; 																		 (powerline-hud face2 face1))))
;; 										 (concat (powerline-render lhs)
;; 														 (powerline-fill face2 (powerline-width rhs))
;; 														 (powerline-render rhs)))))))

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
			  (face1 (if active 'powerline-active1 'powerline-inactive1))
			  (face2 (if active 'powerline-active2 'powerline-inactive2))
			  (separator-left (intern (format "powerline-%s-%s"
							  (powerline-current-separator)
							  (car powerline-default-separator-dir))))
			  (separator-right (intern (format "powerline-%s-%s"
						   (powerline-current-separator)
							   (cdr powerline-default-separator-dir))))

			  (lhs (append (list 
							(powerline-raw "%*" face0 'l)
							(powerline-buffer-id face0 'l)
							(powerline-raw " " face0)
							(powerline-vc face0))
							(if evil-mode
								(list 
										(funcall separator-left face0 (powerline-evil-face))
										(powerline-raw (powerline-evil-tag) (powerline-evil-face))
										(funcall separator-left (powerline-evil-face) face0))
								(list (funcall separator-left mode-line face0)))))

			  (rhs (list (powerline-raw global-mode-string face1 'r)
						 (funcall separator-right face1 face0)
						 (powerline-major-mode face0 'l)
				     ;; (powerline-raw "%4l" face1 'r)
				     ;; (powerline-raw ":" face1)
				     ;; (powerline-raw "%3c" face1 'r)
				     (powerline-raw " " face0)
				     (funcall separator-right face0 face1)
						 (powerline-minor-modes face1 'r)
				     ;; (powerline-raw "%6p" nil 'r)
						 
				     ;; (powerline-hud face0 face1)
						 ))
			  (center (append (list (powerline-raw " " face1)
						(funcall separator-left face1 face2)
						(when (boundp 'erc-modified-channels-object)
						  (powerline-raw erc-modified-channels-object face2 'l))
						(powerline-major-mode face2 'l)
						(powerline-process face2)
						(powerline-raw " " face2))
					  (if (split-string (format-mode-line minor-mode-alist))
					      (append 
						      (list (powerline-minor-modes face2 'l)
							    (powerline-raw " " face2)
							    (funcall separator-right face2 face1)))
					    (list (powerline-raw evil-mode-line-tag face2)
						  (funcall separator-right face2 face1))))))
		     (concat (powerline-render lhs)
			     ;; (powerline-fill-center face1 (/ (powerline-width center) 2.0))
			     ;; (powerline-render center)
			     (powerline-fill face0 (powerline-width rhs))
			     (powerline-render rhs)))))))

(provide 'powerline-dmt-theme)
