(use-package multiple-cursors
	:bind
	("C-S-<down>" . mc/mmlte--down)
	("C->" . mc/mark-next-symbol-like-this)
	:config
	(multiple-cursors-mode t)
	(global-set-key (kbd "C-S-j") 'mc/mmlte--down))
