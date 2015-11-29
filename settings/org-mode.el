;; set key for agenda
(global-set-key (kbd "C-c a") 'org-agenda)

;;file to save todo items
(setq org-agenda-files (quote ("~/Dropbox/Presonal/TODO.org")))

;;set priority range from A to C with default A
(setq org-highest-priority ?A)
(setq org-lowest-priority ?C)
(setq org-default-priority ?A)

;;set colours for priorities
(setq org-priority-faces '((?A . (:foreground "#F0DFAF" :weight bold))
                           (?B . (:foreground "LightSteelBlue"))
                           (?C . (:foreground "OliveDrab"))))

;;open agenda in current window
(setq org-agenda-window-setup (quote current-window))

;;capture todo items using C-c t
(define-key global-map (kbd "C-c t") 'org-capture)
(setq org-capture-templates
      '(("t" "todo" entry (file+headline "~/Dropbox/Personal/TODO.org" "Tasks")
         "* TODO [#A] %?")))

;; Org Repo TODO
(global-set-key (kbd "C-c c") 'ort/capture-todo)
(global-set-key (kbd "C-'") 'ort/capture-checkitem)
(global-set-key (kbd "C-`") 'ort/goto-todos)
;;;;;;;;;;;;;;;;
;; Extensions ;;
;;;;;;;;;;;;;;;;
(use-package org-bullets)
