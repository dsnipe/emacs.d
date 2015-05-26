(use-package git-gutter
	:config
	(progn 
		(global-git-gutter-mode t)
		(setq git-gutter:modified-sign " ")
		(git-gutter:linum-setup)))
