(use-package multiple-cursors
	:bind
	("C-S-<down>" . mc/mmlte--down)
	:config
	(multiple-cursors-mode t)
	(global-set-key (kbd "C-S-j") 'mc/mmlte--down))
