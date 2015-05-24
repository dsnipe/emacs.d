(use-package evil-nerd-commenter
	:config
	(progn
		(setq evilnc-hotkey-comment-operator ",,")
		(global-set-key (kbd "M-/") 'evilnc-comment-or-uncomment-lines)))
