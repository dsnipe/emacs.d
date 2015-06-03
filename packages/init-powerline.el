(use-package powerline
	:config
	(progn
		;; (powerline-center-evil-theme)
	  (require 'powerline-dmt-theme)
		(powerline-dmt-theme)
		(setq powerline-default-separator 'wave) 
		(setq powerline-arrow-shape 'wave)
		;; (powerline-evil-vim-color-theme)
		(setq display-time-24hr-format t)
		(display-time-mode t)
		))

(setq ns-use-srgb-colorspace t)  ;; move to global
