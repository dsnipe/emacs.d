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
		;; add `end` after `do` and `fn`
		(sp-with-modes '(elixir-mode)
			(sp-local-pair "fn" "end"
										 :when '(("SPC" "RET"))
										 :actions '(insert navigate))
			(sp-local-pair "do" "end"
										 :when '(("SPC" "RET"))
										 :post-handlers '(sp-ruby-def-post-handler)
										 :actions '(insert navigate)))))
