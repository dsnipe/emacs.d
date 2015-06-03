(use-package smartparens-config
	:init
	(show-smartparens-global-mode nil)
	(setq sp-autoescape-string-quote nil)
	;; Do not highlight paren area
	(setq sp-highlight-pair-overlay nil)
	(setq sp-highlight-wrap-overlay nil)
	(setq sp-highlight-wrap-tag-overlay nil)
	;; Do not use default slight delay
	(setq show-paren-delay 0)
	:config
	(smartparens-global-mode t))
