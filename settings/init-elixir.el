(use-package elixir-mode)

(use-package alchemist
	:init
	(setq-default alchemist-buffer--mode-name-face nil)
	(defface alchemist-buffer--success-face '((t (:foreground "darkgreen" )))
		"Customize buffer face for alchemist mode"
		:group 'alchemist-buffer)
	(defface alchemist-buffer--failed-face '((t (:foreground "red" )))
		"Customize buffer face for alchemist mode"
		:group 'alchemist-buffer)
	)
