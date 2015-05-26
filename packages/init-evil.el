;;; init-evil.el --- Evil init file
;;; Commentary: 
;;; Code:

(evil-mode 1)
(use-package evil
	:ensure t
	:commands evil-mode
	:init
	(progn
		(setq evil-default-state 'normal)
		(setq evil-default-cursor t)
		(setq evil-auto-indent t)
		(setq evil-shift-width 2)
		(setq evil-search-wrap t)
		(setq evil-find-skip-newlines t)
		(setq evil-move-cursor-back nil)
		(setq evil-mode-line-format 'before)
		(setq evil-esc-delay 0) ;; not wait after <esc>
		(setq evil-cross-lines t))
	
	:config
	(progn
		(evil-mode t)
		(global-evil-leader-mode)

		(evil-leader/set-leader "<SPC>")
		(evil-leader/set-key
										"b" 'switch-to-buffer
										"k" 'kill-buffer
										"e" 'find-file
										"p" 'projectile-find-file)
		(evil-leader/set-key-for-mode 'emacs-lisp-mode "E" 'eval-buffer)

		;; Use C-HJKL to move on windows
		(global-set-key (kbd "C-h") 'windmove-left)
		(global-set-key (kbd "C-l") 'windmove-right)
		(global-set-key (kbd "C-j") 'windmove-down)
		(global-set-key (kbd "C-k") 'windmove-up)

		;; Make ";" behave like ":" in normal mode
		(define-key evil-normal-state-map (kbd ";") 'evil-ex)
		(define-key evil-visual-state-map (kbd ";") 'evil-ex)
		(define-key evil-motion-state-map (kbd ";") 'evil-ex)		
		
		;; use ido to open files
		(define-key evil-ex-map "e " 'ido-find-file)
		;;(define-key evil-ex-map "vs " 'ido-find-file)
		(define-key evil-ex-map "b " 'ido-switch-buffer)

		;;; esc quits
		(define-key evil-normal-state-map [escape] 'keyboard-quit)
		(define-key evil-visual-state-map [escape] 'keyboard-quit)
		(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
		(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
		(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
		(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
		(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

		;; Define `kj` as <ESC>
		(key-chord-define evil-insert-state-map "kj" 'evil-normal-state)
		(define-key evil-insert-state-map "k" #'cofi/maybe-exit)
		(evil-define-command cofi/maybe-exit ()
			:repeat change
			(interactive)
			(let ((modified (buffer-modified-p)))
				(insert "k")
				(let ((evt (read-event (format "" ?j)
															nil 0.5)))
					(cond
					((null evt) (message ""))
					((and (integerp evt) (char-equal evt ?j))
						(delete-char -1)
						(set-buffer-modified-p modified)
						(push 'escape unread-command-events))
					(t (setq unread-command-events (append unread-command-events
																									(list evt))))))))
	)
)

(use-package evil-surround
	:config
	(global-evil-surround-mode t))

