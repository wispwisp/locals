(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)


(setq make-backup-files nil)
;;(setq auto-save-list-file-name nil)
;;(setq auto-save-default nil)


;; brackets hightlight
(setq show-paren-style 'expression)
(show-paren-mode 2)
(menu-bar-mode -1)


;; ----- Not ncurses:
;;(scroll-bar-mode -1)
;;(tool-bar-mode -1)
;;(global-hl-line-mode 1) ; line hightlight
;;(set-default-font "Monaco 32")
;;(setq frame-title-format "emacs - %f")


;;;;;;;;;;;;;;;
;; line numbers
(require 'linum)
(setq linum-format "%d ")
(global-linum-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; file opening variants inline
;;(require 'ido)
;;(ido-mode t)
;;(setq ido-enable-flex-matching t)


;; tabs:
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default c-basic-offset 4)


;; yes/no -> y/n
(fset 'yes-or-no-p 'y-or-n-p)


;; Display line and column numbers
(setq line-number-mode    t)
(setq column-number-mode  t)


;; Line-wrapping
(set-default 'fill-column 80)


;; light-symbol-mode
;;(require 'light-symbol-mode)


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
