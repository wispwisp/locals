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
;; file opening variants inline
;;(require 'ido)
;;(ido-mode t)
;;(setq ido-enable-flex-matching t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
;; +
;; auto-complete for c/cpp (See include dirs: gcc -xc++ -E -v -)
(defun my:ac-c-header-init()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories
               '"/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.3/include/g++-v4"))
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)


;; Semantic
;;(require 'cedet)
;;(semantic-mode 1)
;;(defun my:add-semantic-to-autocomplete()
;;  (add-to-list 'ac-sources 'ac-source-semantic))
;;(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)


;; turn on ede mode
;;(global-ede-mode 1)
;; create a project for our program.
;;(ede-cpp-root-project "my project" :file "~/my_program/src/main.cpp"
;;		      :include-path '("/../my_inc"))
;; you can use system-include-path for setting up the system header file locations.
;; turn on automatic reparsing of open buffers in semantic
;;(global-semantic-idle-scheduler-mode 1)


;;;;;;;;;;;;;;;;;;;;
;; yasnipet
;;(require 'yasnippet)
;;(yas-global-mode 1)


;; jqery documantation
;; press "alt-x jqery-doc" after function
(require 'jquery-doc)
(add-hook 'js2-mode-hook 'jquery-doc-setup)


;; My keys
(global-set-key (kbd "C-c c k") 'comment-region)
(global-set-key (kbd "C-c c u") 'uncomment-region)
(global-set-key (kbd "C-c c <down>") 'scroll-all-mode)
(global-set-key (kbd "C-c c TAB") 'clang-format-region)
;; (global-unset-key (kbd "<f12>"))
;; (global-set-key (kbd "<f12>") ')


;; highlight
(require 'highlight-symbol)
(highlight-symbol-mode t)
(global-set-key (kbd "C-c c s r") 'highlight-symbol-query-replace)
(global-set-key (kbd "C-c c s l") 'highlight-symbol-occur)
(global-set-key (kbd "C-c c s n") 'highlight-symbol-next)
(global-set-key (kbd "C-c c s p") 'highlight-symbol-prev)
(setq highlight-symbol-idle-delay 0.5)


;; regex search
(global-set-key (kbd "M-s") 'search-forward-regexp)
(global-set-key (kbd "M-r") 'search-backward-regexp)


(defun my-purescript-hook ()
  (progn (turn-on-purescript-indent)
         (auto-comlete-mode t)))
(add-hook 'purescript-mode-hook 'my-purescript-hook)


;; c/c++ breakpoints in code.
(defun my:breakpoint ()
  (interactive)
  (insert "asm(\"int $3\");"))
(global-set-key (kbd "C-c c b") 'my:breakpoint)


;; "C-o" to get all occurrences in file
(define-key isearch-mode-map (kbd "C-o")
  (lambda ()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string
               (regexp-quote isearch-string))))))


(defun my:insert-something ()
  (interactive)
  (insert "some text"))
(global-unset-key (kbd "C-c c i"))
(global-set-key (kbd "C-c c i") 'my:insert-something)
