;; main org configurations
(use-package org
  :commands (ox-twbs htmlize)
  :defer 1
  :bind
  (("C-c a" . org-agenda)
   ("C-c l" . org-store-link)
   :map org-mode-map
   ("H-M-'"  . org-metaright)
   ("H-M-;"  . org-metaleft)
   ("H-M-["  . org-metaup)
   ("H-M-/"  . org-metadown)
   ("H-M-\"" . org-shiftmetaright)
   ("H-M-:"  . org-shiftmetaleft)
   ("H-M-?"  . org-shiftmetadown)
   ("H-M-{"  . org-shiftmetaup))
  :config
  ;; general
  (setq org-log-done t)
  (setq org-agenda-files (directory-files "~/.emacs.d/.personal.d/org/tasks" t "^.*\\.org$"))
  ;; export settings
  (setq org-export-in-background t)     ;; run exporting and publishing in background
  (setq org-export-async-debug t)       ;; by default, leave data behind
  (setq org-export-with-sub-superscripts nil)
  ;; looks
  (setq org-src-fontify-natively t)     ;; make source code block prettier
  (setq org-src-tab-acts-natively t)    ;; make tab works as if programming normally
  (defface org-block-begin-line
    '((t (:background "#383838" :foreground "#7F9F7F")))
    "Face used for the line delimiting the begin of source blocks.")
  (defface org-block-background
    '((t (:background "#383838")))
    "Face used for the source block background.")
  (defface org-block-end-line
    '((t (:background "#383838" :foreground "#7F9F7F")))
    "Face used for the line delimiting the end of source blocks."))

;; exporting
(use-package ox-twbs ;; pretty html
  :after (org)
  :defer t)
(use-package htmlize ;; source code to follow formatting in org-mode src blk
  :after (org)
  :defer t)
(use-package ox-pandoc
  :after (org exec-path-from-shell)
  :defer t)

;; display
(use-package org-bullets ;; bullets
  :after (org)
  :init
  (setq org-bullets-bullet-list
        '( "►" "✸" "◉" "○" "◆" "◇" "▸" "•"))
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  :defer t)

;; other editing/export modes
(use-package markdown-mode
  :diminish t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))
