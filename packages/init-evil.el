;;; init-evil.el --- Evil init file
;;; Commentary: 
;;; Code:

(evil-mode 1)
(use-package evil
	:ensure t
	:commands evil-mode
	:init
	(progn
		(setq-default evil-default-state 'normal)
		(setq-default evil-default-cursor nil)
		(setq-default evil-auto-indent t)
		(setq-default evil-want-visual-char-semi-exclusive t)
		(setq-default evil-shift-width 2)
		(setq-default evil-search-wrap t)
		(setq-default evil-find-skip-newlines t)
		(setq-default evil-move-cursor-back nil)
		(setq-default evil-mode-line-format 'before)
		(setq-default evil-esc-delay 0) ;; not wait after <esc>
		(setq-default evil-cross-lines t))
	
	:config
	(progn
		(evil-mode t)
		(global-evil-leader-mode)

		(evil-leader/set-leader "<SPC>")
		(evil-leader/set-key
										"b"  'switch-to-buffer
										"kb" 'kill-buffer
										"e"  'find-file
										"p"  'projectile-find-file
										"w"  'save-buffer
										","  'switch-to-previous-buffer)
		(evil-leader/set-key-for-mode 'emacs-lisp-mode "E" 'eval-buffer)

		;; Visual moving
		(defun dmt/shift-left-visual ()
			"Shift left and restore visual selection."
			(interactive)
			(evil-shift-left (region-beginning) (region-end))
			(evil-normal-state)
			(evil-visual-restore))

		(defun dmt/shift-right-visual ()
			"Shift right and restore visual selection."
			(interactive)
			(evil-shift-right (region-beginning) (region-end))
			(evil-normal-state)
			(evil-visual-restore))

		(defun dmt/shift-right-normal ()
			"Shift right in normal mode"
			(interactive)
			(evil-shift-right (point-at-bol) (point-at-eol)))

		(defun dmt/shift-left-normal ()
			"Shift right in normal mode"
			(interactive)
			(evil-shift-left (point-at-bol) (point-at-eol)))
		
		(define-key evil-visual-state-map (kbd ">") 'dmt/shift-right-visual)
		(define-key evil-normal-state-map (kbd ">") 'dmt/shift-right-normal)
		(define-key evil-visual-state-map (kbd "<") 'dmt/shift-left-visual)
		(define-key evil-normal-state-map (kbd "<") 'dmt/shift-left-normal)
		(define-key evil-visual-state-map (kbd "TAB") 'dmt/shift-right-visual)
		(define-key evil-normal-state-map (kbd "TAB") 'dmt/shift-right-normal)
		(define-key evil-visual-state-map (kbd "<backtab>") 'dmt/shift-left-visual)
		(define-key evil-normal-state-map (kbd "<backtab>") 'dmt/shift-left-normal)
		
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
		(define-key evil-ex-map "eb " 'eval-buffer)
		;;(define-key evil-ex-map "vs " 'ido-find-file)
		(define-key evil-ex-map "b " 'ido-switch-buffer)
		;; emacs binding for end of line movement
		(define-key evil-normal-state-map "\C-e" 'evil-end-of-line)
		(define-key evil-motion-state-map "\C-e" 'evil-end-of-line)
		(define-key evil-insert-state-map "\C-e" 'evil-end-of-line)

		;; Yank whole buffer
		(define-key evil-normal-state-map (kbd "gy") (kbd "gg v G y"))

		(defun fix-underscore-word ()
		(modify-syntax-entry ?_ "w"))

		(defun buffer-exists (bufname)   (not (eq nil (get-buffer bufname))))
		(defun switch-to-previous-buffer ()
			"Switch to previously open buffer.
			Repeated invocations toggle between the two most recently open buffers."
			(interactive)
			;; Don't switch back to the ibuffer!!!
			(if (buffer-exists "*Ibuffer*")  (kill-buffer "*Ibuffer*"))
			(switch-to-buffer (other-buffer (current-buffer) 1)))

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

(use-package evil-visualstar
	:config (global-evil-visualstar-mode))

;; (use-package evil-smartparens
;;   :config
;;   (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode))
