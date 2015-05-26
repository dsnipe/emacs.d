(use-package smart-mode-line
	:init
	(progn
		;; (setq-default mode-line-format '("%e" mode-line-front-space
		;; 						;; Standard info about the current buffer
		;; 						mode-line-mule-info
		;; 						mode-line-client
		;; 						mode-line-modified
		;; 						mode-line-remote
		;; 						mode-line-frame-identification
		;; 						mode-line-buffer-identification " " mode-line-position
		;; 						;; Some specific information about the current buffer:
		;; 						lunaryorn-projectile-mode-line ; Project information
		;; 						(vc-mode lunaryorn-vc-mode-line) ; VC information
		;; 						(flycheck-mode flycheck-mode-line) ; Flycheck status
		;; 						(multiple-cursors-mode mc/mode-line) ; Number of cursors
		;; 						;; Misc information, notably battery state and function name
		;; 						" "
		;; 						mode-line-misc-info
		;; 						;; And the modes, which I don't really care for anyway
		;; 						" " mode-line-modes mode-line-end-spaces))
		(setq sml/theme 'powerline)
		(setq sml/no-confirm-load-theme t))
	:config
	(sml/setup))
