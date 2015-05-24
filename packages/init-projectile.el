(use-package projectile
	;; :commands helm-projectile
	:config
	(projectile-mode t)
	(setq projectile-known-projects-file "~/.emacs.d/tmp/.projectile-bookmarks"
				projectile-switch-project-action 'projectile-dired)
	(setq projectile-project-root-files
				(quote (
								"rebar.config" "project.clj" "SConstruct" "pom.xml" "build.sbt" "build.gradle" "Gemfile"
								"gemfile.rb" "requirements.txt" "package.json" "gulpfile.js" "Gruntfile.js" "bower.json" "composer.json"
								"Cargo.toml" "mix.exs" "README.md" "Cask")))
	(projectile-global-mode)
	;; (setq projectile-completion-system 'grizzl)
	;(helm-projectile-on)

	;; Show projectile lists by most recently active
	(setq projectile-sort-order (quote recently-active))

	;; Key bindings
	(global-unset-key (kbd "M-p"))
	(global-set-key (kbd "M-p") 'projectuke-find-file)
	(dolist (map '(evil-motion-state-map
								evil-normal-state-map
								evil-visual-state-map))
		(define-key (eval map) (kbd "C-p") 'projectile-find-file))
)
;(use-package helm-projectile
;	:defer t
;	:ensure helm-projectile)
