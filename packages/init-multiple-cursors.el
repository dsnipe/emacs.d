(use-package multiple-cursors
	:config
	(multiple-cursors-mode t)
	(global-set-key (kbd "C-S-j") 'mc/mmlte--down)
	;; TODO: Enter in insert mode, and then make action
	(global-set-key (kbd "C-S-D") 'mc/mark-next-like-this))
