(use-package neotree
	:init
	(progn 
		(setq projectile-switch-project-action 'neotree-projectile-action))
	:config
	(progn 
		(global-set-key (kbd "M-\\") 'neotree-toggle))
		(add-hook 'neotree-mode-hook
              (lambda ()
								(define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
								(define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
								(define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
								(define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
								(define-key evil-normal-state-local-map (kbd "H") 'neotree-hidden-file-toggle)
								(define-key evil-normal-state-local-map (kbd "R") 'neotree-rename-node)
								(define-key evil-normal-state-local-map (kbd "C") 'neotree-create-node))))
