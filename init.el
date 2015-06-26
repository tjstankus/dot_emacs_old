;; packages
(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

;; disable toolbar
(tool-bar-mode -1)

;; display column number in modeline
(column-number-mode t)

;; disable bell
(setq ring-bell-function 'ignore)

;; relative line numbers
(global-relative-line-numbers-mode)
(set-default 'linum-format "%3d")
(set-default 'relative-line-numbers-format
             (lambda (offset)
               (format "%3d" (abs offset))))

;; TODO: Figure out why this made layout crazy when window smaller
;;       than widest line in Ruby file
;; column marker
;; (add-hook 'ruby-mode-hook (lambda ()
;;                             (turn-on-auto-fill)
;;                             (fci-mode)
;;                             (set-fill-column 81)))

;; themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'zenburn t)

;; markdown
(autoload 'gfm-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

;; disable backup and autosave files
(setq make-backup-files nil)
(setq auto-save-default nil)

;; wrap at window edge, keep words together
(global-visual-line-mode 1)

;; Make underscores not be a word boundary
;; See: http://emacs.stackexchange.com/questions/9583/how-to-treat-underscore-as-part-of-the-word
(defadvice evil-inner-word (around underscore-as-word activate)
  (let ((table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?_ "w" table)
    (with-syntax-table table
      ad-do-it)))

;; disable tabs
;; TODO: Insert 2 spaces when tab is pressed in insert mode
(setq-default indent-tabs-mode nil)
;; set tab stops every 2 spaces
(setq tab-stop-list (number-sequence 2 140 2))
;; (setq c-basic-offset 2) ;; not sure what this does

;; show tabs and trailing whitespace
(setq whitespace-style '(trailing tabs tab-mark))

;; column width
(setq-default fill-column 80)

;; org-mode
;; todos
(setq org-todo-keywords
  '((sequence "TODO" "WIP" "|" "DONE" "PUNTED")))
;; clock
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-agenda-files '("~/Dropbox/org-notes"))

;; helm
(require 'helm-config)
(helm-mode 1)
(setq helm-buffers-fuzzy-matching t)

;; evil-leader
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "w" 'save-buffer
  "b" 'helm-buffers-list
  "ct" 'org-todo
  "xi" 'org-clock-in
  "xo" 'org-clock-out)

;; evil mode
(require 'evil)
(evil-mode 1)

;; Make movement keys work on visual lines when soft wrapped
(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
;; Make horizontal movement cross lines
(setq-default evil-cross-lines t)

;; start emacs server
(server-start)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "1157a4055504672be1df1232bed784ba575c60ab44d8e6c7b3800ae76b42f8bd" "646676b902afda86f22bc66a2e14dbae7c0fc2fc988cc2fc11099ef5684b7a78" default)))
 '(org-agenda-files
   (quote
    ("~/Dropbox (Personal)/org-notes/spreedly/securedev/securedev.org")))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "nil" :slant normal :weight normal :height 141 :width normal)))))
