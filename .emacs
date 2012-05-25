;; 显行行号
(require 'linum)
(global-linum-mode t)
(setq column-number-mode t)
(setq line-number-mode t)

;; 不产生备份文件
(setq make-bakcup-file nil)
(setq make-backup-files nil)
(setq-default make-backup-files nil)

;; 主题
(add-to-list 'load-path "color-theme.el")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-hober)))
;(color-theme-dark-blue)

;; Erlang mode
(setq erlang-root-dir "/usr/lib/erlang/")
(setq erlang-man-root-dir (concat erlang-root-dir "man/"))
(setq erlang-bin-root-dir (concat erlang-root-dir "bin/"))
(setq erlang-tools-dir (concat erlang-root-dir "/lib/tools-2.6.6.5/emacs"))
(add-to-list 'load-path erlang-tools-dir)
(add-to-list 'exec-path erlang-bin-root-dir)
(require 'erlang-start)
(require 'erlang-flymake)

;; Distel
(add-to-list 'load-path "~/.emacs.d/distel/share/distel/elisp")
(require 'distel)
(distel-setup)

;; Some Erlang customizations
(add-hook 'erlang-mode-hook
  (lambda ()
    ;; when starting an Erlang shell in Emacs, default in the node name
    (setq inferior-erlang-machine-options '("-sname" "emacs"))
    ;; add Erlang functions to an imenu menu
    (imenu-add-to-menubar "imenu")))

;; prevent annoying hang-on-compile
(defvar inferior-erlang-prompt-timeout t)

;; tell distel to default to that node
(setq erl-nodename-cache
        (make-symbol
	    (concat
	     "emacs@"
	     (car (split-string(shell-command-to-string "hostname"))))))

;; A number of the erlang-extended-mode key bindings are useful in the shell too
(defconst distel-shell-keys
  '(("\C-\M-i"   erl-complete)
    ("\M-?"      erl-complete) 
    ("\M-."      erl-find-source-under-point)
    ("\M-,"      erl-find-source-unwind) 
    ("\M-*"      erl-find-source-unwind) 
    )
  "Additional keys to bind when in Erlang shell.")
(add-hook 'erlang-shell-mode-hook
   (lambda ()
     ;; add some Distel bindings to the Erlang shell
     (dolist (spec distel-shell-keys)
       (define-key erlang-shell-mode-map (car spec) (cadr spec)))))
