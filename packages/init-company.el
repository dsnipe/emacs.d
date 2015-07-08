(use-package company
	:defer 2
	:init
	(progn 
		(setq company-idle-delay 0.5
					company-echo-delay 0
					company-begin-commands '(self-insert-command)
					company-dabbrev-downcase nil
					company-selection-wrap-around t
					company-tooltip-limit 10
					company-minimum-prefix-length 2
					company-tooltip-flip-when-above t))
	:config
	(progn 
		(global-company-mode t)

		;; Disable Alchemist backend
		(add-hook 'alchemist-mode-hook
				`(lambda ()
						(setq company-backends (delete 'alchemist-company company-backends))))
		
		(defun check-expansion ()
			(save-excursion
				(if (looking-at "\\_>") t
					(backward-char 1)
					(if (looking-at "\\.") t
						(backward-char 1)
						(if (looking-at "->") t nil)))))

		(defun do-yas-expand ()
			(let ((yas/fallback-behavior 'return-nil))
				(yas/expand)))

		(defun tab-indent-or-complete ()
			(interactive)
			(cond
			 ((minibufferp)
				(minibuffer-complete))
			 (t
				(indent-for-tab-command)
				(if (or (not yas/minor-mode)
								(null (do-yas-expand)))
						(if (check-expansion)
								(progn
									(company-manual-begin)
									(if (null company-candidates)
											(progn
												(company-abort)
												(indent-for-tab-command)))))))))

		(defun tab-complete-or-next-field ()
			(interactive)
			(if (or (not yas/minor-mode)
							(null (do-yas-expand)))
					(if company-candidates
							(company-complete-selection)
						(if (check-expansion)
								(progn
									(company-manual-begin)
									(if (null company-candidates)
											(progn
												(company-abort)
												(yas-next-field))))
							(yas-next-field)))))

		(defun expand-snippet-or-complete-selection ()
			(interactive)
			(if (or (not yas/minor-mode)
							(null (do-yas-expand))
							(company-abort))
					(company-complete-selection)))

		(defun abort-company-or-yas ()
			(interactive)
			(if (null company-candidates)
					(yas-abort-snippet)
				(company-abort)))

		(global-set-key [tab] 'tab-indent-or-complete)
		(global-set-key (kbd "TAB") 'tab-indent-or-complete)
		;; (global-set-key [(control return)] 'company-complete-common)

		(define-key company-active-map [tab] 'expand-snippet-or-complete-selection)
		(define-key company-active-map (kbd "TAB") 'expand-snippet-or-complete-selection)

		(define-key yas-minor-mode-map [tab] nil)
		(define-key yas-minor-mode-map (kbd "TAB") nil)

		(define-key yas-keymap [tab] 'tab-complete-or-next-field)
		(define-key yas-keymap (kbd "TAB") 'tab-complete-or-next-field)
		(define-key yas-keymap [(control tab)] 'yas-next-field)
		(define-key yas-keymap (kbd "C-g") 'abort-company-or-yas)
		
		;; Add yasnippet support for all company backends
		(defvar company-mode/enable-yas t
				"Enable yasnippet for all backends.")

		(defun company-mode/backend-with-yas (backend)
				(if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
						backend
						(append (if (consp backend) backend (list backend))
																'(:with company-yasnippet))))
		(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
		))

