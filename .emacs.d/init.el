(setq inhibit-startup-message t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)

(menu-bar-mode -1)

(setq visible-bell t)

(set-face-attribute 'default nil :font "Fira Code Retina" :height 280)

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(show-paren-mode t)

(use-package swiper
  :ensure t)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper) :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line) :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line) 
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill) :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1)
  )

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom (doom-modeline-height 15))

(require 'auto-complete)
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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(use-package tide rust-mode org iedit fstar-mode flycheck-irony evil dracula-theme dante company-irony-c-headers company-irony boogie-friends bison-mode bar-cursor auto-complete-c-headers 4clojure 2048-game)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
