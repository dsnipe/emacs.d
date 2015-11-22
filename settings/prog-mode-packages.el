(use-package smartparens-config
	:init
	(progn
		(show-smartparens-global-mode nil)
		(setq sp-autoescape-string-quote nil)
		;; Do not highlight paren area
		(setq sp-highlight-pair-overlay nil)
		(setq sp-highlight-wrap-overlay nil)
		(setq sp-highlight-wrap-tag-overlay nil)
		;; Do not use default slight delay
		(setq show-paren-delay 0))
	:config
	(progn
		(smartparens-global-mode t)
    
		(sp-local-pair 'css-mode "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))
    (sp-local-pair 'js2-mode "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))
    (sp-local-pair 'js2-jsx-mode "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))

    (defun my-create-newline-and-enter-sexp (&rest _ignored)
      "Open a new brace or bracket expression, with relevant newlines and indent. "
      (newline)
      (indent-according-to-mode)
      (forward-line -1)
      (indent-according-to-mode))
		;; add `end` after `do` and `fn` for Elixir Lang
		(sp-with-modes '(elixir-mode)
			(sp-local-pair "fn" "end"
										 :when '(("SPC" "RET"))
										 :actions '(insert navigate))
			(sp-local-pair "do" "end"
										 :when '(("SPC" "RET"))
										 :post-handlers '(sp-ruby-def-post-handler)
										 :actions '(insert navigate)))))

(use-package flycheck
	:commands global-flycheck-mode
	:defer 2
  :init
  (progn
    (when (display-graphic-p (selected-frame))
      '(custom-set-variables
        '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages))))
	:config
	(progn
		(setq-default flycheck-check-syntax-automatically '(mode-enable save idle-change)
					flycheck-completition-system 'ido
					flycheck-highlighting-mode 'sexps
					flycheck-disabled-checkers '(html-tidy emacs-lisp emacs-lisp-checkdoc
                                                 javascript-jshint json-jsonlist
                                                 javascript-gjslint))
    
		;; (add-hook 'prog-mode-hook #'global-flycheck-mode)
    (global-flycheck-mode)
    ;; (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)
    ;; flycheck errors on a tooltip (doesnt work on console)
    (setq flycheck-checkers '(javascript-eslint))
    ;; use eslint with web-mode for jsx files
    (flycheck-add-mode 'javascript-eslint 'web-mode)
    (flycheck-add-mode 'javascript-eslint 'js2-mode)
    (flycheck-add-mode 'javascript-eslint 'js-mode)
    ;; (setq flycheck-standard-error-navigation nil)
    (flycheck-pos-tip-mode)
    ))

(use-package yaml-mode
	:config
	(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode)))

