(server-start)
(toggle-frame-maximized)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)


;; ido
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-enable-flex-matching 1)
(setq vc-follow-symlinks nil)

;; recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 50)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; look
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
(powerline-default-theme)
(set-face-attribute 'mode-line-inactive nil
                    :underline t
                    :background (face-background 'default))
(global-set-key (kbd "S-M-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-M-<down>") 'shrink-window)
(global-set-key (kbd "S-M-<up>") 'enlarge-window)

(require 'linum)
(setq linum-format " %d ")
;; (global-linum-mode)

;; (require 'solarized)
;; (deftheme solarized-dark "Solarized dark")
;; (create-solarized-theme 'dark 'solarized-dark)
;; (provide-theme 'solarized-dark)
;; (load-theme 'wombat t)
(load-theme 'monokai t)

;; tabs and whitespaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(add-hook 'local-write-file-hooks
          (lambda ()
            (delete-trailing-whitespace)
            nil))

(setq-default left-margin-width 1 right-margin-width 1)
 (set-window-buffer nil (current-buffer))


;; (defconst user-tmp-dir "~/tmp/")
;; (setq backup-directory-alist
;;   `(("." . ,user-tmp-dir)))

;; (setq
;;  backup-by-copying t
;;  delete-old-versions t
;;  kept-new-versions 6
;;  kept-old-versions 2
;;  version-control t)

;; (setq auto-save-file-name-transforms
;;     `((".*" ,user-tmp-dir t)))
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq create-lockfiles nil)

;; projectile
(projectile-global-mode)
(setq projectile-enable-caching t)

;; neotree
(global-set-key [f12] 'neotree-toggle)
(add-hook 'neotree-mode-hook
          (lambda ()
            (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
            (define-key evil-normal-state-local-map (kbd "o") 'neotree-enter)))

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)


;; complete
(add-hook 'after-init-hook 'global-company-mode)


;; evil
(evil-mode)
(setq evil-shift-width 2)
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-mode 1)
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

;; haskell
;(require 'haskell-interactive-mode)
;(require 'haskell-process)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(custom-set-variables
  '(haskell-process-suggest-remove-import-lines t)
  '(haskell-process-auto-import-loaded-modules t)
  '(haskell-process-log t))
(eval-after-load 'haskell-mode '(progn
  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
  (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
  (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
  (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)
  (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)))
(eval-after-load 'haskell-cabal '(progn
  (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))
(define-key haskell-mode-map (kbd "M-.") 'haskell-mode-jump-to-def)

;; snippets
(yas-global-mode 1)

;; html
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)

;; markdown
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; config types
(add-to-list 'auto-mode-alist '("\\.*rc$" . conf-mode))

;; javascript
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . jsx-mode))
(defvar flycheck-jshintrc "~/.jshintrc")
;; (add-hook 'js-mode-hook
;;           (lambda ()
(setq tab-width 2)
(setq js-indent-level 2)
(setq jsx-indent-level 2)
;; ))

(add-hook 'jsx-mode-hook
          (lambda ()
            (emmet-mode)
            (setq tab-width 2)
            (setq js-indent-level 2)
            (setq jsx-indent-level 2)))


;; web-mode
(add-hook 'web-mode-hook
          (lambda()
            (setq web-mode-markup-indent-offset 2)
            (setq web-mode-css-indent-offset 2)
            (setq web-mode-code-indent-offset 2)
            (define-key web-mode-map (kbd "C-n") 'web-mode-tag-match)
            (setq web-mode-enable-css-colorization t)
            ))


;; python
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
;; (add-hook 'python-mode-hook 'anaconda-mode)
;; (add-hook 'python-mode-hook 'eldoc-mode)
(add-hook 'python-mode-hook
          (lambda ()
            (setq tab-width 4)
            (setq python-indent 4)
            (setq evil-shift-width 4)))


;; keys
(global-set-key (kbd "<f2>") 'save-buffer)
(global-set-key (kbd "<f10>") 'kill-buffer)


;; aliases
(defalias 'yes-or-no-p 'y-or-n-p)


(setq my-packages '(
                    auto-complete
                    cl-lib
                    ctable
                    dash
                    deferred
                    el-get
                    emmet-mode
                    epc
                    epl
                    evil
                    evil-nerd-commenter
                    evil-surround
                    flycheck
                    flymake
                    fuzzy
                    goto-chg
                    jedi
                    key-chord
                    let-alist
                    neotree
                    pkg-info
                    popup
                    powerline
                    pymacs
                    python-environment
                    rope
                    ropemacs
                    ropemode
                    solarized-emacs
                    undo-tree
                    writeroom-mode
                    yasnippet
                    ))

;; scheme
(autoload 'scheme-smart-complete "scheme-complete" nil t)
(eval-after-load 'scheme
  '(define-key scheme-mode-map "\t" 'scheme-complete-or-indent))
