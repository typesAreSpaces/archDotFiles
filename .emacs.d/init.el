(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
    'package-archives
    '("melpa" . "http://melpa.milkbox.net/packages/")
    t)
  )
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3ed03e990d6f830a0e2ec0a0a05d6e13fc596416d99d3bd87467f47929d75ba7" "274fa62b00d732d093fc3f120aca1b31a6bb484492f31081c1814a858e25c72e" default)))
 '(package-selected-packages
   (quote
    (lavenderless-theme 2048-game 4clojure evil bison-mode boogie-friends org-edna bar-cursor dante auctex iedit auto-complete-c-headers auto-complete company-irony company-irony-c-headers flycheck-irony dracula-theme rust-mode fstar-mode tide))))

(show-paren-mode t)

;; Start auto-complete with emacs
(require 'auto-complete)
;; Do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)

(setq ispell-program-name "aspell") 
(setq ispell-dictionary "english") 

(require 'evil)
(evil-mode t)

;; Open .v files with Proof General's Coq mode
;;(load "~/.emacs.d/lisp/PG/generic/proof-site")
;; Let Proof General find coqtop
;;(setq coq-prog-name "/usr/bin/coqtop") 
