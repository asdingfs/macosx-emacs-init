;; main org configurations
(use-package org
  :commands (ox-md ox-twbs htmlize)
  :bind
  (("C-c a" . org-agenda)
   ("C-c c" . org-capture) 
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
  :init
  (add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
  :config
  ;; general
  (setq org-log-done t)
  (setq org-goto-auto-isearch nil)
  (setq org-agenda-files (directory-files "~/.emacs.d/.personal.d/org" t "^.*\\.org$"))
  (setq org-imenu-depth 3)
  (setq org-src-window-setup 'current-window)
  ;; refiling
  (setq org-refile-targets (quote ((nil :maxlevel . 3)
                                   (org-agenda-files :maxlevel . 2))))    ;; use header lvl 1 in ALL registed agenda files
  (setq org-refile-use-outline-path (quote file))                         ;; refile includes relative file name
  (setq org-refile-allow-creating-parent-nodes (quote confirm))           ;; confirm if creating a new parent node
  (setq org-outline-path-complete-in-steps nil)                           ;; show all steps, for ivy autocomplete

  ;; export settings
  (setq org-export-in-background t)     ;; run exporting and publishing in background
  (setq org-export-async-debug t)       ;; by default, leave data behind
  (setq org-export-with-sub-superscripts nil)
  (setq org-export-backends '(ascii html icalendar latex odt md))
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
;; pretty html
(use-package ox-twbs)
 ;; source code to follow formatting in org-mode src blk
(use-package htmlize :after (org))
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
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown")
  :config
  (setq markdown-fontify-code-blocks-natively t)
  (set-face-attribute 'markdown-code-face nil :family "Inconsolata"))
(use-package markdown-preview-mode
  :defer t)

;; interface with pandoc
(use-package pandoc-mode
  :init
  (load "pandoc-mode")
  :config
  (add-hook 'markdown-mode-hook 'pandoc-mode)
  (add-hook 'pandoc-mode-hook 'pandoc-load-default-settings))
