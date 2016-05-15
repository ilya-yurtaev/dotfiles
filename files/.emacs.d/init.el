(require 'cask "~/.cask/cask.el")
(cask-initialize)

(require 'pallet)
(pallet-mode t)

(exec-path-from-shell-initialize)

(server-start)
(toggle-frame-maximized)

(setq ns-pop-up-frames nil)
(add-to-list 'display-buffer-alist
             '("^[^\\*].*[^\\*]$" display-buffer-same-window) t)

;; look
(setq frame-title-format "%b — Emacs")
(load-theme 'monokai t)
;; (powerline-default-theme)
(set-face-attribute 'mode-line nil  :height 1 :box nil :underline "#554")
(setq mode-line-in-non-selected-windows nil)
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
;; (setq linum-format " %d ")
(setq-default left-margin-width 1 right-margin-width 1)
(set-window-buffer nil (current-buffer))
(setq initial-scratch-message "")

;; shell
(setq system-uses-terminfo nil)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; speedbar
(require 'sr-speedbar)
(setq speedbar-use-images nil)
(global-set-key (kbd "<f8>") 'sr-speedbar-toggle)
(speedbar-add-supported-extension ".hs")


;; tabs and whitespaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(add-hook 'local-write-file-hooks
          (lambda ()
            (delete-trailing-whitespace)
            nil))


(paredit-everywhere-mode)
(dolist (mode '(ruby espresso js2))
  (add-hook (intern (format "%s-mode-hook" mode))
            '(lambda ()
               (add-to-list (make-local-variable 'paredit-space-for-delimiter-predicates)
                            (lambda (_ _) nil))
               (enable-paredit-mode))))

;; backups, locks and tmp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq create-lockfiles nil)

;; evil
(require 'evil)
(require 'key-chord)
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
(require 'ido)
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
(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-switch-project-action 'neotree-projectile-action)


;; recent files

;; flycheck
(require 'flycheck)
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

;; config types
(add-to-list 'auto-mode-alist '("\\.*rc$" . conf-mode))

;; haskell
(require 'haskell)
(require 'haskell-process)
(require 'haskell-interactive-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'structured-haskell-mode)

(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))


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
(require 'shm-case-split)
(define-key shm-map (kbd "C-c C-s") 'shm/case-split)

;; elm
(add-hook 'elm-mode-hook #'elm-oracle-setup-completion)
(add-to-list 'company-backends 'company-elm)

;; lisp
(require 'slime)
(setq inferior-lisp-program "/usr/bin/sbcl")
(setq slime-contribs '(slime-fancy))

;; javascript
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(setq js-indent-level 2)
(setq js2-basic-offset 2)
(setq js2-bounce-indent-p t)
(add-hook 'js-mode-hook
          (function (lambda ()
                      (setq evil-shift-width 2))))

(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))

(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))

(flycheck-add-mode 'javascript-eslint 'web-mode)

(setq-default flycheck-temp-prefix ".flycheck")

(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(json-jsonlist)))

;; python
(require 'python-mode)
(add-hook 'python-mode-hook
          (function (lambda ()
                      (setq python-indent 4)
                      (setq evil-shift-width 4))))
(setq python-shell-interpreter "ipython"
    python-shell-interpreter-args "-i")

;; keys
(global-set-key (kbd "<f2>") 'save-buffer)
(global-set-key (kbd "S-M-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-M-<down>") 'shrink-window)
(global-set-key (kbd "S-M-<up>") 'enlarge-window)

(defun insert-current-date () (interactive)
    (insert (shell-command-to-string "echo -n $(date +%Y-%m-%d)")))


(defalias 'yes-or-no-p 'y-or-n-p)

(require 'package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-ghc-show-info t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote stack-ghci))
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/")))))
