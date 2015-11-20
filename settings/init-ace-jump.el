(use-package ace-jump-mode
	:defer t
	:init
	(progn 
		(add-hook 'ace-jump-mode-end-hook 'golden-ratio)
		(evil-leader/set-key "\\" 'evil-ace-jump-word-mode)
		(evil-leader/set-key "l" 'evil-ace-jump-line-mode)
		(evil-leader/set-key "c" 'evil-ace-jump-char-mode)
		(define-key evil-normal-state-map (kbd "\\") 'ace-jump-mode)
		(global-set-key (kbd "C-c f") 'ace-jump-mode)
		:config
		;; (setq ace-jump-word-mode-use-query-char nil)
		(setq ace-jump-mode-scope 'global)
		(evil-leader/set-key "`" 'ace-jump-mode-pop-mark)))
