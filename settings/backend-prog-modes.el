;;;;;;;;;;
;; Ruby ;;
;;;;;;;;;;
(use-package ruby-mode :init
	(setenv "PAGER" "cat")
	:config
	(progn 
		(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
		(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
		(add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
		(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
		(add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
		(add-to-list 'auto-mode-alist '("Vagrantfile\\'" . ruby-mode))
		(add-to-list 'auto-mode-alist '("Guardfile\\'" . ruby-mode))

		;; Hooks
		(add-hook 'ruby-mode-hook 'minitest-mode)
		(add-hook 'ruby-mode-hook 'robe-mode)
		(add-hook 'ruby-mode-hook 'yard-mode)
		;; (add-hook 'robe-mode-hook 'ac-robe-setup)
		(add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)

		(eval-after-load 'company
			'(push 'company-robe company-backends))))

(use-package rbenv
    ;; :defer t
	:init
	(progn
		(setq rbenv-instaltation-dir "/usr/local/Cellar/rbenv/0.4.0/")
		(setq rbenv-modeline-function 'rbenv--modeline-plain))
  :config
	(progn 
		(add-hook 'ruby-mode-hook 'global-rbenv-mode)))

(use-package minitest
    :defer
    :config
    '(minitest-install-snippets))

(use-package ruby-block
	;; :init
	;; (setq ruby-block-highlight-toggle t)
	:config
	(ruby-block-mode t))

;;;;;;;;;;;;;
;; Elixir ;;;
;;;;;;;;;;;;;

(use-package elixir-mode)

(use-package alchemist
	:init
	(setq-default alchemist-buffer--mode-name-face nil)
	(defface alchemist-buffer--success-face '((t (:foreground "darkgreen" )))
		"Customize buffer face for alchemist mode"
		:group 'alchemist-buffer)
	(defface alchemist-buffer--failed-face '((t (:foreground "red" )))
		"Customize buffer face for alchemist mode"
		:group 'alchemist-buffer))
