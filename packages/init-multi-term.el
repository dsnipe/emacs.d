(use-package multi-term
	:init
	(progn
		(setq multi-term-dedicated-close-back-to-open-buffer-p t)
		(setq multi-term-program "/bin/zsh")
	;; (add-to-list 'term-unbind-key-list '("C-h" "C-j" "C-l" "C-k"))
		)
	:config
	(progn 
		(global-set-key (kbd "§") 'it-multi-term-dedicated-toggle)
		(defun it-multi-term-dedicated-toggle ()
			"jump back to previous location after toggling ded term off"
			(interactive)
			(if (multi-term-dedicated-exist-p)
					(progn
						(multi-term-dedicated-toggle)
						(switch-to-buffer old-buf))
				(progn
					(setq old-buf (current-buffer))
					(multi-term-dedicated-toggle)
					(multi-term-dedicated-select))
				)
			)
	)
)
