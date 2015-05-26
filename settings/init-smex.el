(use-package smex
	:bind (("M-x" . smex))
	:config
	(progn
	(setq-default smex-history-length 10
									smex-flex-matching t)
	(smex-initialize)))
