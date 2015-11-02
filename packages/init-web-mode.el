(use-package web-mode
	:config
	(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
	(add-to-list 'auto-mode-alist '("\\.eex\\'" . web-mode))
	(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

	(define-key web-mode-map (kbd "C-n") 'web-mode-tag-match)

	(add-hook 'web-mode-hook 'turn-off-smartparens-mode))

(use-package js2-mode
	:config
	(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (setq js2-missing-semi-one-line-override t)
  (setq-default js2-basic-offset 2))

(use-package css-mode
  :config
  (setq css-indent-offset 2))
