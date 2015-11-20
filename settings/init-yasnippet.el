(use-package yasnippet
	;; :ensure t
	;; :commands yas-minor-mode-map
	;; :defer 1
	:config
	(progn
		;; Suppress excessive log messages
		(setq yas-verbosity -1
					yas-prompt-functions '(yas-ido-prompt)
					yas-snippet-dir "~/.emacs.d/snippets")
		(yas-global-mode t)))

