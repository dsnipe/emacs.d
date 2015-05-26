(use-package magit
	:commands (magit-status magit-diff magit-log magit-blame-mode)
	:init
	(setq magit-last-seen-setup-instructions "1.4.0")
	(evil-leader/set-key
		"g s" 'magit-status
		"g l" 'magit-log)
	:config
	(progn
		(evil-make-overriding-map magit-mode-map 'emacs)
		;; (define-key magit-mode-map (kbd "C-w" 'evil-window-map))
		(evil-define-key 'emacs magit-mode-map "j" 'magit-goto-nex-section)
		(evil-define-key 'emacs magit-mode-map "k" 'magit-goto-previous-section)
		(evil-define-key 'emacs magit-mode-map "K" 'magit-diskard-item)))
