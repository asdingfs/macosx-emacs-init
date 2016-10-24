;; fuzzy matching
(use-package flx
  :defer t)

;; for searching files
(use-package ag
  :defer t)

;; use projectile for project file finders
(use-package projectile
  :diminish projectile-mode
  :init
  (setq projectile-completion-system 'ivy)
  :config
  (projectile-global-mode t))

;; better search with swiper: installs ivy-mode too
(use-package ivy
  :diminish ivy-mode
  :bind
  (("C-c C-r" . ivy-resume))
  :init
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-re-builders-alist
        '((swiper . ivy--regex-plus)
          (t . ivy--regex-fuzzy)))
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-height 10)
  :config
  (ivy-mode 1))
(use-package swiper
  :after (ivy)
  :bind
  (("C-s" . swiper)
   ("C-r" . swiper)))

;; replace vanilla finders with counsel, closely tied to ivy-mode
(use-package counsel
  :after (swiper)
  :bind
  (("M-x" . counsel-M-x)
   ("M-y" . counsel-yank-pop)
   ("C-x C-f" . counsel-find-file)
   ("C-h f" . counsel-describe-function)
   ("C-h v" . counsel-describe-variable)
   ("C-x C-d" . counsel-file-jump) 
   ("C-x r l" . counsel-bookmark)
   ("C-h x" . counsel-imenu)
   ("C-c SPC g" . counsel-git)
   ("C-c SPC j" . counsel-git-grep)
   ("C-c SPC s" . counsel-ag)))

;; inter package integrations
(use-package counsel-projectile
  :after (counsel projectile)
  :init
  (counsel-projectile-on))
(use-package projectile-rails
  :defer t
  :after (counsel-projectile)
  :init 
  (setq projectile-rails-add-keywords t)
  (setq projectile-rails-expand-snippet t)
  (progn
    (add-hook 'projectile-mode-hook 'projectile-rails-on)
    (add-hook 'enh-ruby-mode-hook 'projectile-rails-on)))
