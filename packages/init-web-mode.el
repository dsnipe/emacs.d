(use-package web-mode
	:config
	(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
	(add-to-list 'auto-mode-alist '("\\.eex\\'" . web-mode))
	(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

	(define-key web-mode-map (kbd "%") 'web-mode-tag-match))
