(use-package yasnippet
	:ensure t
	:commands
	yas-minor-mode-map
	:defer 1
	:config
	(progn
		;; Suppress excessive log messages
		(setq yas-verbosity 1
					yas-prompt-functions '(yas-ido-prompt)
					yas-snippet-dir (expand-file-name "snippets" user-emacs-directory))
		    (yas-global-mode t)))

