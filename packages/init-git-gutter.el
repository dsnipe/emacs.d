;; (use-package git-gutter+
;; 	:config
;; 	(progn 
;; 		(global-git-gutter+-mode t)))

;; (use-package git-gutter-fringe+)
(use-package git-gutter
	:init
	(progn
		;; (setq git-gutter:modified-sign " ")
		)
	:config
	(progn 
		(global-git-gutter-mode t)
		(git-gutter:linum-setup)
		(custom-set-variables '(git-gutter:update-interval 2))))

