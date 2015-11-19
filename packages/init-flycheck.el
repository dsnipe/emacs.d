;;; init-flycheck.el --- Flycheck init file
;; Commenentary:
;;; Code:

(use-package flycheck
	:commands global-flycheck-mode
	:defer 2
	:config
	(progn
		(setq-default flycheck-check-syntax-automatically '(mode-enable save idle-change)
					flycheck-completition-system 'ido
					flycheck-highlighting-mode 'sexps
					flycheck-disabled-checkers '(html-tidy emacs-lisp emacs-lisp-checkdoc)))
	(progn
		(global-flycheck-mode t)))
; (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)
;; flycheck errors on a tooltip (doesnt work on console)
;;(when (display-graphic-p (selected-frame))
;;  (eval-after-load 'flycheck
 ;;   '(custom-set-variables
;;	'(flycheck-display-errors-function #'flycheck-pos-tip-error-messages))))
; (eval-after-load "flycheck"
;     '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))
; (after 'flycheck
;       (setq flycheck-checkers (delq 'emacs-lisp-checkdoc flycheck-checkers))
;       (setq flycheck-checkers (delq 'html-tidy flycheck-checkers))
;       (setq flycheck-standard-error-navigation nil))

(provide 'init-flycheck)

;;; init-flycheck.el ends here
