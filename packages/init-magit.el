(use-package magit
	:commands (magit-status magit-diff magit-log magit-blame-mode)
	:init
	;; (setq magit-last-seen-setup-instructions "1.4.0")
	(global-set-key (kbd "C-x g") 'magit-status)
	(evil-leader/set-key
		;; "g s" 'magit-status
		;; "g l" 'magit-log
		"ms" 'magit-status
		"ml" 'magit-log
		"mb" 'magit-branch-manager
		"mp" 'magit-push)
	:config
	(progn
		(evil-make-overriding-map magit-mode-map 'emacs)
		;; (define-key magit-mode-map (kbd "C-w" 'evil-window-map))
		(evil-define-key 'emacs magit-mode-map "K" 'magit-diskard-item)))
