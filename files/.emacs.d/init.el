(require 'cask "~/.cask/cask.el")
(cask-initialize)

(require 'pallet)
(pallet-mode t)

(exec-path-from-shell-initialize)

(server-start)
(toggle-frame-maximized)

;; look
(load-theme 'monokai t)
(powerline-default-theme)
(setq ns-pop-up-frames nil)
(setq font-lock-maximum-decoration t)
(setq frame-background-mode 'dark)
(set-frame-font "Ubuntu Mono-14")
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(menu-bar-mode -1)
(global-hl-line-mode)
(global-auto-revert-mode 1)
(set-fringe-mode 0)
(setq visible-bell nil)
(set-face-attribute 'mode-line-inactive nil
                    :underline t
                    :background (face-background 'default))
(global-set-key (kbd "S-M-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-M-<down>") 'shrink-window)
(global-set-key (kbd "S-M-<up>") 'enlarge-window)
(setq linum-format " %d ")
(setq-default left-margin-width 1 right-margin-width 1)
 (set-window-buffer nil (current-buffer))


;; tabs and whitespaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(add-hook 'local-write-file-hooks
          (lambda ()
            (delete-trailing-whitespace)
            nil))


(autopair-global-mode)

;; backups, locks and tmp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq create-lockfiles nil)

;; evil
(evil-mode)
(setq evil-shift-width 2)
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-mode 1)

(require 'evil-leader)
(evil-leader/set-leader ",")
(global-evil-leader-mode)
(evil-leader/set-key
  "ci" 'evilnc-comment-or-uncomment-lines
  "cu" 'evilnc-comment-or-uncomment-lines
  "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
  "ll" 'evilnc-quick-comment-or-uncomment-to-the-line
  "cc" 'evilnc-copy-and-comment-lines
  "cp" 'evilnc-comment-or-uncomment-paragraphs
  "cr" 'comment-or-uncomment-region
  "cv" 'evilnc-toggle-invert-comment-line-by-line
  )
(global-evil-surround-mode 1)

;; commenter
(global-set-key (kbd "M-;") 'evilnc-comment-or-uncomment-lines)
(global-set-key (kbd "C-c l") 'evilnc-quick-comment-or-uncomment-to-the-line)
(global-set-key (kbd "C-c c") 'evilnc-copy-and-comment-lines)
(global-set-key (kbd "C-c p") 'evilnc-comment-or-uncomment-paragraphs)

;; ido
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-enable-flex-matching 1)
(setq vc-follow-symlinks nil)

;; helm
(helm-mode 1)
(global-set-key "\C-x\ \C-r" 'helm-recentf)
(global-set-key "\C-x\ \C-f" 'helm-find-files)

;; projectile
(projectile-global-mode)
(setq projectile-enable-caching t)

;; recent files

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; neotree
(global-set-key (kbd "<f12>") 'neotree-toggle)
(add-hook 'neotree-mode-hook
          (lambda ()
            (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
            (define-key evil-normal-state-local-map (kbd "o") 'neotree-enter)))

;; complete
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(add-to-list 'company-backends 'company-ghc)
(custom-set-variables '(company-ghc-show-info t))

;; config types
(add-to-list 'auto-mode-alist '("\\.*rc$" . conf-mode))

;; haskell
;; (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'structured-haskell-mode)
;; (add-hook 'haskell-mode-hook (lambda () (ghc-init)))
(custom-set-variables
  '(haskell-process-suggest-remove-import-lines t)
  '(haskell-process-auto-import-loaded-modules t)
  '(haskell-process-type 'stack-ghci)
  '(haskell-process-log t))
(eval-after-load 'haskell-mode '(progn
  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
  (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
  (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
  (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)
  (define-key haskell-mode-map (kbd "M-.") 'haskell-mode-jump-to-def)
  (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)))
(eval-after-load 'haskell-cabal '(progn
  (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))

;; keys
(global-set-key (kbd "<f2>") 'save-buffer)
