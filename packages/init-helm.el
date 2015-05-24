(require 'helm-config)
(require 'helm-misc)
(require 'helm-projectile)
(require 'helm-mode)
(require 'helm-match-plugin)
(require 'helm-buffers)
(require 'helm-files)
(require 'helm-locate)
(require 'helm-tags)
(require 'helm-semantic)

(use-package helm
	:ensure t
	:commands helm-candidate-number
	:init
	(progn		
		(setq helm-quick-update                     t ; do not display invisible candidates
					helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
					helm-bookmark-show-location           t ; ??
					helm-buffers-fuzzy-matching           t ; fuzzy matching buffer names when non--nil
					helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
					helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
					helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
					helm-ff-skip-boring-files             t
					helm-boring-file-regexp-list          '("\\.$" "\\.\\.$")
					helm-ff-file-name-history-use-recentf t
					helm-input-idle-delay               0.2
					helm-split-window-default-side   'other ;open helm buffer in another window
					helm-display-header-line nil
					helm-autoresize-max-height 30
					helm-autoresize-min-height 10)
		(helm-mode 1)
		(helm-autoresize-mode t)

		;; Key bindings
		(global-set-key (kbd "M-x") 'helm-M-x)
		;; (global-set-key (kbd "C-p") 'helm-projectile)
		(global-set-key (quote [C-p]) 'helm-projectile)
		(global-set-key (kbd "C-t") 'helm-projectile)
		(define-key helm-map (kbd "C-j") 'helm-next-source)
		(define-key helm-map (kbd "C-k") 'helm-previous-source)
		(global-set-key (kbd "M-v") 'helm-show-kill-ring))
	:config
	(progn 
		(set-face-attribute 'helm-selection nil :background "#262626" :foreground "#fff")
		(set-face-attribute 'helm-candidate-number nil :background "#2875d7" :foreground "#fff") 
		(set-face-attribute 'helm-source-header nil
												:background (face-attribute 'helm-selection :background)
												:foreground "white"
												:family "Source Code Pro"
												:box nil
												:height 0.1)))


(use-package helm-descbinds
	:defer t
	:bind ("C-c b" . helm-descbinds))

(use-package helm-swoop)

		;; Show source headers if more than 1 sources
		;; (defvar helm-source-header-default-background (face-attribute 'helm-source-header :background))
		;; (defvar helm-source-header-default-foreground (face-attribute 'helm-source-header :foreground))
		;; (defvar helm-source-header-default-box (face-attribute 'helm-source-header :box))
		;; (defun helm-toggle-header-line ()
		;; 	(if (> (length helm-sources) 1)
		;; 			(set-face-attribute 'helm-source-header
		;; 													nil
		;; 													:foreground helm-source-header-default-foreground
		;; 													:background helm-source-header-default-background
		;; 													:box helm-source-header-default-box
		;; 													:height 1.0)
		;; 		(set-face-attribute 'helm-source-header
		;; 												nil
		;; 												:foreground (face-attribute 'helm-selection :background)
		;; 												:background (face-attribute 'helm-selection :background)
		;; 												:box nil
		;; 												:height 0.1)))
;; (defun helm-my-buffers ()
;; 	"Preconfigured `helm'."
;; 	(interactive)
;; 	;; (let ((helm-ff-transformer-show-only-basename nil)))
;; 	(condition-case nil
;; 			(if (projectile-project-root)
;; 					;; add project files and buffers when in project
;; 					(helm-other-buffer '(
;; 															 helm-source-projectile-buffers-list
;; 															 helm-source-projectile-files-list
;; 															 helm-c-source-buffers-list
;; 															 helm-c-source-elscreen
;; 															 ;; helm-c-source-ctags
;; 															 helm-c-source-recentf
;; 															 helm-c-source-locate)
;; 														 "*helm-my-buffers*"))
;; 		;; otherwise fallback to helm-mini
;; 		(helm-mini))
;; 	;; fall back to helm mini if an error occurs (usually in projectile-project-root)
;; 	(error (helm-mini)))
