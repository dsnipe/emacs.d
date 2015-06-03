(use-package ido
	:config
	(progn
		(ido-mode t)
		(ido-everywhere 1)
		(flx-ido-mode 1)
		(setq ido-decorations (quote ("\n↪ "     "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]"
																" [Too big]" " [Confirm]")))
		(setq ido-ignore-buffers '("^ " "*Completions*" "*Shell Command Output*"
														"*Messages*" "Async Shell Command"))
		;; disable ido faces to see flx highlights.
		(setq ido-enable-flex-matching t
					ido-use-faces nil)
		(setq ido-create-new-buffer 'always
					ido-max-prospects      50)))

(use-package ido-vertical-mode
	:defer 1
	:config
	(ido-vertical-mode))
