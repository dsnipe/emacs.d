;;; packages.el --- Common packages settings
;;; Commentary: Settings for common packages, installed in Emacs
;;; Code:

(use-package smart-tab
	:config
	(global-smart-tab-mode 1))


(use-package move-text
	:bind
	(("M-S-<up>" . move-text-up)
	 ("M-S-<down>" . move-text-down)))

;; Show and create matching parens automaticaly
;; (show-paren-mode t)
;; (use-package popwin
;;   :config
;;     (popwin-mode t))

(use-package zoom-window
	:config
	(define-prefix-command 'ctrl-w-map)
	(global-set-key (kbd "C-w") 'ctrl-w-map)
	(define-key ctrl-w-map (kbd "z") 'zoom-window-zoom))

;; 
(use-package dired-efap
	:config
	(define-key dired-mode-map [f2] 'dired-efap))

;; (use-package polymode
;;   :config
;;   (add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode)))

(use-package mmm-mode
  :init
  (defun my-mmm-markdown-auto-class (lang &optional submode)
    "Define a mmm-mode class for LANG in `markdown-mode' using SUBMODE.
If SUBMODE is not provided, use `LANG-mode' by default."
    (let ((class (intern (concat "markdown-" lang)))
          (submode (or submode (intern (concat lang "-mode"))))
          (front (concat "^```" lang "[\n\r]+"))
          (back "^```"))
      (mmm-add-classes (list (list class :submode submode :front front :back back)))
      (mmm-add-mode-ext-class 'markdown-mode nil class)))

  ;; Mode names that derive directly from the language name
  (mapc 'my-mmm-markdown-auto-class
        '("awk" "bibtex" "c" "cpp" "css" "html" "js" "lisp" "makefile"
          "markdown" "python" "r" "ruby" "sql" "json" "xml"))
  :config
  (setq mmm-parse-when-idle 't)
  (global-set-key (kbd "C-c m p") 'mmm-parse-buffer))

(use-package expand-region
	:config (global-set-key (kbd "C-=") 'er/expand-region))

(use-package key-chord
	:ensure t
	:commands key-chord-define
	:init (setq key-chord-two-keys-delay 0.075)
	:config (key-chord-mode 1))

(use-package evil-nerd-commenter
	:config
	(progn
		(setq evilnc-hotkey-comment-operator ",,")
		(global-set-key (kbd "M-/") 'evilnc-comment-or-uncomment-lines)))

(use-package multiple-cursors
	:config
	(multiple-cursors-mode t)
	(global-set-key (kbd "C-S-j") 'mc/mmlte--down)
	;; TODO: Enter in insert mode, and then make action
	(global-set-key (kbd "C-S-D") 'mc/mark-next-like-this))

(use-package magit
	:commands (magit-status magit-diff magit-log magit-blame-mode)
	:init
	;; (setq magit-last-seen-setup-instructions "1.4.0")
	(global-set-key (kbd "C-x g") 'magit-status)
	(evil-leader/set-key
		;; "g s" 'magit-status
		;; "g l" 'magit-log
		"ms" 'magit-status
		"ml" 'magit-log
		"mb" 'magit-branch-manager
		"mp" 'magit-push)
	:config
	(progn
		(evil-make-overriding-map magit-mode-map 'emacs)
		;; (define-key magit-mode-map (kbd "C-w" 'evil-window-map))
		(evil-define-key 'emacs magit-mode-map "K" 'magit-diskard-item)))

;; Install brew install ctags-exuberant
;; brew install global --with-exuberant-ctags
;; (use-package ggtags)
 
;; HideShow
;; http://www.emacswiki.org/emacs/HideShow
(global-set-key (kbd "C-M-[") 'hs-hide-block)
(global-set-key (kbd "C-M-]") 'hs-show-block)
(global-set-key (kbd "C-M-_") 'hs-hide-all)

(defadvice goto-line (after expand-after-goto-line
                            activate compile)
  "hideshow-expand affected block when using goto-line in a collapsed buffer"
  (save-excursion
    (hs-show-block)))

(defun display-code-line-counts (ov)
  (when (eq 'code (overlay-get ov 'hs))
    (overlay-put ov 'display
                 (format "... / %d"
                         (count-lines (overlay-start ov)
                                      (overlay-end ov))))))

(setq hs-set-up-overlay 'display-code-line-counts)

; Ruby HideShow support
(add-to-list 'hs-special-modes-alist
             '(ruby-mode
               "\\(def\\|do\\|{\\)" "\\(end\\|end\\|}\\)" "#"
               (lambda (arg) (ruby-end-of-block)) nil))

(add-hook 'prog-mode-hook #'hs-minor-mode)

(use-package emamux)

(use-package neotree
	:init
	(progn 
		(setq projectile-switch-project-action 'neotree-projectile-action))
	:config
	(progn 
		(global-set-key (kbd "M-\\") 'neotree-toggle))
		(add-hook 'neotree-mode-hook
              (lambda ()
								(define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
								(define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
								(define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
								(define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
								(define-key evil-normal-state-local-map (kbd "H") 'neotree-hidden-file-toggle)
								(define-key evil-normal-state-local-map (kbd "R") 'neotree-rename-node)
								(define-key evil-normal-state-local-map (kbd "C") 'neotree-create-node))))

(use-package diff-hl
  :config
  (diff-hl-mode 1)
  (diff-hl-flydiff-mode 1))

(use-package multi-term
	:init
	(progn
		(setq multi-term-dedicated-close-back-to-open-buffer-p t)
		(setq multi-term-program "/bin/zsh")
	;; (add-to-list 'term-unbind-key-list '("C-h" "C-j" "C-l" "C-k"))
		)
	:config
	(progn
		(defun term-send-tab ()
			"Send tab for complettiotn"
			(interactive)
			(term-send-raw-string "\t"))
		(add-to-list 'term-bind-key-alist '("<tab>" . term-send-tab))
		;; (global-set-key (kbd "§") 'it-multi-term-dedicated-toggle)
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
					(multi-term-dedicated-select))))))

