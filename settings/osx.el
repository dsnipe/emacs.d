;; mac specific settings
(when (eq system-type 'darwin) 
;; (setq mac-option-modifier 'alt)
	;; (setq mac-command-modifier 'meta)
	(global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
	)

;; (unless window-system
;; 	(setq mac-command-modifier 'meta))

(setq ns-function-modifier 'super)
