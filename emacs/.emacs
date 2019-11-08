(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; required packages
(setq package-list '(auto-complete
                     highlight-symbol
                     ggtags
                     markdown-mode
                     clang-format
                     dockerfile-mode))

;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


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


;;;;;;;;;;
;; My keys

;; (global-unset-key (kbd "<f12>"))
;; (global-set-key (kbd "<f12>") ')

(global-set-key (kbd "C-c c d d") 'delete-trailing-whitespace)
(global-set-key (kbd "C-c c <down>") 'scroll-all-mode)
(global-set-key (kbd "C-c c TAB") 'clang-format-region)

(global-set-key (kbd "C-c c k") 'comment-region)
(global-set-key (kbd "C-c c u") 'uncomment-region)

(global-set-key (kbd "M-s") 'search-forward-regexp)
(global-set-key (kbd "M-r") 'search-backward-regexp)

(global-set-key (kbd "C-M-y") 'revert-buffer)

(global-set-key (kbd "ESC <left>")  'windmove-left)
(global-set-key (kbd "ESC <right>") 'windmove-right)
(global-set-key (kbd "ESC <up>")    'windmove-up)
(global-set-key (kbd "ESC <down>")  'windmove-down)

(global-set-key (kbd "M-<left>")  'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>")    'windmove-up)
(global-set-key (kbd "M-<down>")  'windmove-down)


;; highlight
(require 'highlight-symbol)
(highlight-symbol-mode t)
(global-set-key (kbd "C-c c s r") 'highlight-symbol-query-replace)
(global-set-key (kbd "C-c c s l") 'highlight-symbol-occur)
(global-set-key (kbd "C-c c s n") 'highlight-symbol-next)
(global-set-key (kbd "C-c c s p") 'highlight-symbol-prev)
(global-set-key (kbd "C-c c s q") 'highlight-symbol-at-point)
(global-set-key (kbd "C-c c s w") 'unhighlight-regexp)
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
(defun hs-my-hiding-keys ()
  (hs-minor-mode 1)
  (global-set-key (kbd "<f10>")
                  (lambda () (interactive) (hs-toggle-hiding)))
  (global-set-key (kbd "<f9>")
                  (lambda () (interactive) (hs-hide-level 0))))

(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode) (hs-my-hiding-keys))))
(add-hook 'python-mode-hook 'hs-my-hiding-keys)


;; tags
(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'asm-mode)
              (ggtags-mode 1)
              (global-set-key (kbd "M-,") 'pop-tag-mark)
              (global-set-key (kbd "<f12>") 'ggtags-find-reference))))


;; Search (When in isearch)
;; "C-o" to get all occurrences in file
(define-key isearch-mode-map (kbd "C-o")
  (lambda ()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string
               (regexp-quote isearch-string))))))


;; calendar
(add-hook 'calendar-load-hook
          (lambda ()
            ;; (calendar-set-date-style 'iso)
            (setq calendar-week-start-day 1)))


;;;;;;;;;;;;;;;;
;; my insertions

(defun my:breakpoint () ;; c/c++ breakpoints in code.
  (interactive)
  (insert "asm(\"int $3\");"))
(global-set-key (kbd "C-c c i b") 'my:breakpoint)

(defun my:insert:smth ()
  (interactive)
  (insert "..."))
(global-unset-key (kbd "C-c c i i "))
(global-set-key (kbd "C-c c i i") 'my:insert:smth)

(defun my:insert:for ()
  (interactive)
  (insert "for (std::size_t i=0; i<; i++) {\n;\n}")
  (backward-char 12))
(global-unset-key (kbd "C-c c i f i"))
(global-set-key (kbd "C-c c i f i") 'my:insert:for)

(defun my:insert:foreach ()
  (interactive)
  (insert "std::for_each(std::begin(), std::end(), [](){});\n")
  (backward-char 24))
(global-unset-key (kbd "C-c c i f e"))
(global-set-key (kbd "C-c c i f e") 'my:insert:foreach)

(defun my:insert:coutn ()
  (interactive)
  (insert "std::cout << \"\\n\";")
  (backward-char 4))
(global-unset-key (kbd "C-c c i c n"))
(global-set-key (kbd "C-c c i c n") 'my:insert:coutn)

(defun my:insert:coutendl ()
  (interactive)
  (insert "std::cout <<  << std::endl;")
  (backward-char 14))
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
