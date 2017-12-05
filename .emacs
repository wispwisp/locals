(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)


;; No startup screen
(setq inhibit-startup-screen t)


;; no new line at the end of a file
;; (setq require-final-newline nil)
;; (setq mode-require-final-newline nil)


;; saving
(setq make-backup-files nil)
;;(setq auto-save-list-file-name nil)
;;(setq auto-save-default nil)


;; brackets hightlight
(setq show-paren-style 'expression)
(show-paren-mode 2)
(menu-bar-mode -1)


;; tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)


;; yes/no -> y/n
(fset 'yes-or-no-p 'y-or-n-p)


;; Dirent by 'a' - do not open new buffers
(put 'dired-find-alternate-file 'disabled nil)


;; Display line and column numbers
(setq line-number-mode    t)
(setq column-number-mode  t)


;;;;;;;;;;;;;;;
;; line numbers
(require 'linum)
(setq linum-format "%d ")
(global-linum-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)


;; jqery documantation
;; press "alt-x jqery-doc" after function
(require 'jquery-doc)
(add-hook 'js2-mode-hook 'jquery-doc-setup)


;;;;;;;;;;
;; My keys

;; (global-unset-key (kbd "<f12>"))
;; (global-set-key (kbd "<f12>") ')

(global-set-key (kbd "C-c c k") 'comment-region)
(global-set-key (kbd "C-c c u") 'uncomment-region)
(global-set-key (kbd "C-c c <down>") 'scroll-all-mode)
(global-set-key (kbd "C-c c TAB") 'clang-format-region)

(global-set-key (kbd "M-s") 'search-forward-regexp)
(global-set-key (kbd "M-r") 'search-backward-regexp)

(global-set-key (kbd "C-M-y") 'revert-buffer)

(global-set-key (kbd "ESC <left>")  'windmove-left)
(global-set-key (kbd "ESC <right>") 'windmove-right)
(global-set-key (kbd "ESC <up>")    'windmove-up)
(global-set-key (kbd "ESC <down>")  'windmove-down)


;; highlight
(require 'highlight-symbol)
(highlight-symbol-mode t)
(global-set-key (kbd "C-c c s r") 'highlight-symbol-query-replace)
(global-set-key (kbd "C-c c s l") 'highlight-symbol-occur)
(global-set-key (kbd "C-c c s n") 'highlight-symbol-next)
(global-set-key (kbd "C-c c s p") 'highlight-symbol-prev)
(setq highlight-symbol-idle-delay 0.5)


;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c c w") 'whitespace-mode)


;; todo: new line and clang-format
;; automatically indent when press RET
;; (global-set-key (kbd "RET") 'newline-and-indent)


;; show redundant trailing whitespaces
(add-hook 'prog-mode-hook (lambda ()
                            (interactive)
                            (setq show-trailing-whitespace 1)))


;; folding
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode)
              (hs-minor-mode 1)
              (global-set-key (kbd "<f10>")
                              (lambda () (interactive) (hs-toggle-hiding)))
              (global-set-key (kbd "<f11>")
                              (lambda () (interactive) (hs-hide-level 0)))
              )))


;; tags
(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'asm-mode)
              (ggtags-mode 1)
              (global-set-key (kbd "<f12>") 'ggtags-find-reference))))


;;;;;;;;;;;;;
;; purescript
(defun my:purescript-hook ()
  (progn (turn-on-purescript-indent)
         (auto-comlete-mode t)))
(add-hook 'purescript-mode-hook 'my:purescript-hook)


;; Search
;; "C-o" to get all occurrences in file
(define-key isearch-mode-map (kbd "C-o")
  (lambda ()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string
               (regexp-quote isearch-string))))))


;;;;;;;;;;;;;;;;
;; my insertions

;;;;;;;;;;;;;;;;;;;;
;; yasnipet
;;(require 'yasnippet)
;;(yas-global-mode 1)

;; c/c++ breakpoints in code.
(defun my:breakpoint ()
  (interactive)
  (insert "asm(\"int $3\");"))
(global-set-key (kbd "C-c c b") 'my:breakpoint)

(defun my:insert:smth ()
  (interactive)
  (insert "..."))
(global-unset-key (kbd "C-c c i i "))
(global-set-key (kbd "C-c c i i") 'my:insert:smth)

(defun my:insert:coutn ()
  (interactive)
  (insert "std::cout << \"\\n\";")
  (backward-char 4))
(global-unset-key (kbd "C-c c i c n"))
(global-set-key (kbd "C-c c i c n") 'my:insert:coutn)

(defun my:insert:coutendl ()
  (interactive)
  (insert "std::cout <<  << \"\\n\";")
  (backward-char 9))
(global-unset-key (kbd "C-c c i c e"))
(global-set-key (kbd "C-c c i c e") 'my:insert:coutendl)


;;;;;;;;;;;;;;;;;;;
;; my functionality
(defun my:grep()
  "Fast grep call with '-Rni' flags and quoted text"
  (interactive)
  (let* ((pattern (read-from-minibuffer "Search pattern: "))
         (path (read-from-minibuffer "Path: "))
         (command (format "grep -Rni \"%s\" %s" pattern path)))
    (async-shell-command command)))
(global-unset-key (kbd "<f6>"))
(global-set-key (kbd "<f6>") 'my:grep)


(defun my:grep-marked()
  "Fast grep call with '-Rni' flags and quoted text"
  (interactive)
  (let* ((pattern (buffer-substring (mark) (point)))
         (path (read-from-minibuffer "Path: "))
         (command (format "grep -Rni \"%s\" %s" pattern path)))
    (async-shell-command command)))
(global-unset-key (kbd "<f7>"))
(global-set-key (kbd "<f7>") 'my:grep-marked)
