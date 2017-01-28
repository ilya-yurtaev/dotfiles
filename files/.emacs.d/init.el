
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(exec-path-from-shell-initialize)

(toggle-frame-maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; (toggle-frame-fullscreen)

(setq ns-pop-up-frames nil)
;; (add-to-list 'display-buffer-alist
;;              '("^[^\\*].*[^\\*]$" display-buffer-same-window) t)

;; look
(setq frame-title-format "%b — Emacs")
;; (load-theme 'base16-greenscreen-dark t)
;; (load-theme 'base16-default-dark t)
;; (load-theme 'solarized-dark t)
;; (load-theme 'atom-one-dark-theme t)
(load-theme 'monokai t)
(set-face-attribute 'mode-line nil  :height 1 :box nil :underline "#553")
(setq mode-line-in-non-selected-windows nil)
(setq font-lock-maximum-decoration 1)
(setq frame-background-mode 'dark)
;; (set-frame-font "Ubuntu Mono-14")
(add-to-list 'default-frame-alist
             '(font . "Ubuntu Mono-14"))
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(scroll-bar-mode -1)
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
(set-face-bold 'bold nil)
(set-face-italic 'italic nil)


;; shell
(setq system-uses-terminfo nil)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; speedbar
;;(setq speedbar-use-images nil)
;;(global-set-key (kbd "<f8>") 'sr-speedbar-toggle)
;;(speedbar-add-supported-extension ".hs")


;; tabs and whitespaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(add-hook 'local-write-file-hooks
          (lambda ()
            (delete-trailing-whitespace)
            nil))
(add-hook 'before-save-hook 'delete-trailing-whitespace)


(paredit-everywhere-mode)
(dolist (mode '(ruby espresso js3))
  (add-hook (intern (format "%s-mode-hook" mode))
            '(lambda ()
               (add-to-list (make-local-variable 'paredit-space-for-delimiter-predicates)
                            (lambda (_ _) nil))
               (enable-paredit-mode))))

;; backups, locks and tmp
(setq auto-save-default nil)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq create-lockfiles nil)
(desktop-save-mode 1)


;; evil
(require 'evil)
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
(recentf-mode 1)
(setq-default recent-save-file "~/.emacs.d/recentf")
(setq helm-fuzzy-match t)
(setq helm-completion-in-region-fuzzy-match t)
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)

;; projectile
(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-switch-project-action 'neotree-projectile-action)
(helm-projectile-on)

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; neotree
(setq neo-smart-open t)
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

;; ycmd
(set-variable 'ycmd-global-config (expand-file-name "~/.ycmd_extra_conf.py"))
(set-variable 'ycmd-server-command '("ycmd"))
(company-ycmd-setup)
(flycheck-ycmd-setup)
(when (not (display-graphic-p))
  (setq flycheck-indication-mode nil))
(add-hook 'after-init-hook #'global-ycmd-mode)

;; ggtags
;; (ggtags-global-mode)

;; config types
(add-to-list 'auto-mode-alist '("\\.*rc$" . conf-mode))

;; forth
(autoload 'forth-mode "gforth.el")
(setq auto-mode-alist (cons '("\\.fs\\'" . forth-mode) auto-mode-alist))

;; c/c++
;; (modern-c++-font-lock-global-mode t)

;; haskell
;; (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
;; (add-hook 'haskell-mode-hook 'structured-haskell-mode)
(add-hook 'haskell-mode-hook 'intero-mode)

;; (autoload 'ghc-init "stack ghc" nil t)
;; (autoload 'ghc-debug "stack ghc" nil t)
;; (add-hook 'haskell-mode-hook (lambda () (ghc-init)))
(setq haskell-tags-on-save t)


;; scss
(require 'scss-mode)



(eval-after-load 'haskell-mode '(progn
                                  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
                                  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
                                  (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
                                  (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
                                  (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
                                  (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)
                                  (define-key haskell-mode-map (kbd "M-.") 'haskell-mode-jump-to-def)))
(eval-after-load 'haskell-cabal '(progn
                                   (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
                                   (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
                                   (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
                                   (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))

;; elm
(add-to-list 'company-backends 'company-elm)
(setq elm-format-on-save t)
(with-eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-elm-setup))
(add-hook 'elm-mode-hook #'elm-oracle-setup-completion)

;; lisp
(setq inferior-lisp-program "/usr/bin/sbcl")
(setq slime-contribs '(slime-fancy))

;; javascript
(add-to-list 'auto-mode-alist '("\\.js\\'" . js3-mode))
(setq js-indent-level 2)
(setq js3-basic-offset 2)
(setq js3-bounce-indent-p t)
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

(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)

;; python
(elpy-enable)
(add-hook 'python-mode-hook
          (function (lambda ()
                      (highlight-indentation-mode 0)
                      (setq python-indent-offset 4)
                      (local-set-key (kbd "M-.") 'elpy-goto-definition)
                      (setq evil-shift-width 4))))
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i")

;; org mode
(require 'org-alert)
;; (org-alert-enable)
;; (setq org-alert-notification-title "Org")
;; (setq alert-default-style 'libnotify)
(setq org-agenda-include-diary t)
(setq org-startup-indented t)
(setq org-hide-leading-stars t)
(setq org-log-repeat 'note)
(setq diary-file "~/org/diary")

;; calendar
(setq calendar-time-zone 300)
(setq calendar-week-start-day 1)
(setq calendar-date-style "european")

;; snippets
(require 'yasnippet)
(global-set-key (kbd "H-w") 'create-auto-yasnippet)
(global-set-key (kbd "H-y") 'expand-auto-yasnippet)

;; keys
(global-set-key (kbd "<f1>") 'save-buffer)
(global-set-key (kbd "<f2>") 'save-buffer)
(global-set-key (kbd "S-M-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-M-<down>") 'shrink-window)
(global-set-key (kbd "S-M-<up>") 'enlarge-window)
;; (global-set-key (kbd "S-M-h") 'shrink-window-horizontally)
;; (global-set-key (kbd "S-M-r") 'enlarge-window-horizontally)
;; (global-set-key (kbd "S-M-j") 'shrink-window)
;; (global-set-key (kbd "S-M-k") 'enlarge-window)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key (kbd "<f10>") 'kill-this-buffer)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/todos.org" "Tasks")
         "* TODO %T %?:")
        ("j" "Journal" entry (file+headline "~/org/journal.org" "Journal")
         "* %T %?")))



(defun insert-current-date () (interactive)
       (insert (shell-command-to-string "echo -n $(date +%Y-%m-%d)")))

(defalias 'yes-or-no-p 'y-or-n-p)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-ghc-show-info t)
 '(compilation-message-face (quote default))
 '(custom-safe-themes
   (quote
    ("c567c85efdb584afa78a1e45a6ca475f5b55f642dfcd6277050043a568d1ac6f" default)))
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-flymake elpy-module-pyvenv elpy-module-yasnippet elpy-module-sane-defaults)))
 '(evil-shift-width 2)
 '(fci-rule-color "#49483E")
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote stack-ghci))
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#49483E" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#49483E" . 100))))
 '(magit-diff-use-overlays nil)
 '(neo-theme (quote ascii))
 '(org-agenda-files
   (quote
    ("~/org/journal.org" "~/org/todos.org" "~/org/daily.org")))
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (faceup git-commit magit-popup php-mode auto-complete cider clojure-mode flycheck helm helm-core jedi-core magit request with-editor yasnippet yaml-mode yagist writeroom-mode web-mode web-beautify use-package typed-clojure-mode turnip sr-speedbar solarized-theme smex smartparens slime shm scss-mode ruby-tools rainbow-mode rainbow-delimiters racket-mode python-mode py-autopep8 projectile-speedbar project-explorer prodigy powerline popwin paredit-everywhere pallet org-alert org-agenda-property nodejs-repl nginx-mode neotree nasm-mode monokai-theme markdown-mode key-chord jsx-mode json-mode js3-mode js2-refactor jedi-direx intero idle-highlight-mode htmlize hindent helm-projectile helm-mode-manager helm-ls-hg helm-ls-git helm-gtags helm-ghc go-mode gnus-desktop-notify ggtags geiser flycheck-ycmd flycheck-irony flycheck-ghcmod flycheck-dialyzer flycheck-cask flx-ido expand-region exec-path-from-shell evil-surround evil-paredit evil-org evil-nerd-commenter evil-magit esup ess emmet-mode elpy elm-mode el-get edts ediprolog drupal-mode drag-stuff ctags company-ycmd company-web company-jedi company-irony company-ghci company-ghc color-theme-sanityinc-tomorrow coffee-mode clojure-mode-extra-font-locking clang-format auto-yasnippet atom-one-dark-theme)))
 '(pos-tip-background-color "#A6E22E")
 '(pos-tip-foreground-color "#272822")
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" "node_modules" "bower_components")))
 '(scss-compile-at-save nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (unspecified "#272822" "#49483E" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
