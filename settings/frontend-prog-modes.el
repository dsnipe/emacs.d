(use-package js2-mode
  :init
  (progn
    (setq js2-missing-semi-one-line-override t)
    (setq js2-basic-offset 2)
    (setq js2-mode-show-strict-warnings nil)
    (setq js2-mode-show-parse-errors nil))
	:config
  (progn
    (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))))

(use-package web-mode
  :mode "\\.js\\'\\|\\.html\\'"
  :init
  (progn
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-css-indent-offset 2)
    (setq web-mode-code-indent-offset 2))
	:config
  (progn 
    (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.eex\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

    (define-key web-mode-map (kbd "C-n") 'web-mode-tag-match)
    (add-hook 'web-mode-hook 'turn-off-smartparens-mode)
    ;; ReactJS settings
    (add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
    (defadvice web-mode-highlight-part (around tweak-jsx activate)
      (if (equal web-mode-content-type "jsx")
          (let ((web-mode-enable-part-face nil))
            ad-do-it)
        ad-do-it))
    (defun rm-maybe-jsx-mode ()
      (when (string-equal "jsx" web-mode-content-type)
        (subword-mode 1)
        (js2-minor-mode 1)))
    (add-hook 'web-mode-hook 'rm-maybe-jsx-mode)
    (add-to-list 'web-mode-content-types '("jsx" . "js/.*\\.js\\'"))
    ))

(use-package css-mode
  :config
  (setq css-indent-offset 2))

