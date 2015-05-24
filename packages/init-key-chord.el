(use-package key-chord
	:ensure t
	:commands key-chord-define
	:init
	(setq key-chord-two-keys-delay 0.075)
	:config
	(key-chord-mode 1))
