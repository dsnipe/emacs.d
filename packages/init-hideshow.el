;; HideShow
;; http://www.emacswiki.org/emacs/HideShow
(global-set-key (kbd "C-M-[") 'hs-hide-block)
(global-set-key (kbd "C-M-]") 'hs-show-block)
;; (global-set-key (kbd "M-+") 'hs-show-all)
;; (global-set-key (kbd "M-_") 'hs-hide-all)
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
