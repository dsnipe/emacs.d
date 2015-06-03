(use-package enh-ruby-mode
	:init
	(progn 
	    (add-to-list 'auto-mode-alist '("\\.rake\\'" . enh-ruby-mode))
	    (add-to-list 'auto-mode-alist '("\\.ru\\'" . enh-ruby-mode))
	    (add-to-list 'auto-mode-alist '("Rakefile\\'" . enh-ruby-mode))
	    (add-to-list 'auto-mode-alist '("\\.gemspec\\'" . enh-ruby-mode))
	    (add-to-list 'auto-mode-alist '("Gemfile\\'" . enh-ruby-mode))
	    (add-to-list 'auto-mode-alist '("Vagrantfile\\'" . enh-ruby-mode)))
	    (add-to-list 'auto-mode-alist '("Guardfile\\'" . enh-ruby-mode))

	    ;; Hooks
	    (add-hook 'enh-ruby-mode-hook 'minitest-mode)
	    (add-hook 'enh-ruby-mode-hook 'robe-mode)
	    (add-hook 'robe-mode-hook 'ac-robe-setup)
			(add-hook 'enh-ruby-mode-hook 'inf-ruby-minor-mode)

	    (eval-after-load 'company
		    '(push 'company-robe company-backends)))

(use-package rbenv
    ;; :defer t
    :config
    (global-rbenv-mode))

(use-package minitest
    :defer
    :config
    '(minitest-install-snippets))
