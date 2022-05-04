(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package auto-package-update
  :custom
  (auto-package-update-hide-results t)
  (auto-package-update-delete-old-versions t))

;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                    (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)

;; NOTE: If you want to move everything out of the ~/.emacs.d folder
;; reliably, set `user-emacs-directory` before loading no-littering!
                                        ;(setq user-emacs-directory "~/.cache/emacs")

(use-package no-littering)

;; no-littering doesn't set this by default so we must place
;; auto save files in the same path as it uses for sessions
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

;; NOTE: init.el is now generated from Emacs.org.  Please edit that file
;;       in Emacs and init.el will be generated automatically!

;; You will most likely need to adjust this font size for your system!
(defvar efs/default-font-size 160)
(defvar efs/default-variable-font-size 160)

;; Make frame transparency overridable
(defvar efs/frame-transparency '(90 . 90))

(defvar phd-thesis-dir "~/Documents/GithubProjects/phd-thesis")
(defvar phd-thesis-org-files-dir
  (concat phd-thesis-dir
          "/Documents/Org-Files"))
(defvar scc-org-files-dir 
  (concat phd-thesis-dir
          "/Documents/Side-Projects/kapur-nsf-proposal/Org-Files"))
(defvar seminar-org-files-dir 
  (concat phd-thesis-dir
          "/Documents/Seminars/BeihangUniversity-Fall2021/Org-Files"))
(defvar ta-org-files-dir 
  (concat phd-thesis-dir
          "/Documents/Semesters/Spring/2022/TA-CS-429-529/Org-Files"))

(defvar research-tasks-mail 
  (concat phd-thesis-org-files-dir "/research_tasks.org"))
(defvar lunch-tasks-mail 
  (concat phd-thesis-org-files-dir "/lunch_tasks.org"))
(defvar side-tasks-mail 
  (concat phd-thesis-org-files-dir "/side_tasks.org"))
(defvar scc-tasks-mail 
  (concat scc-org-files-dir "/scc_tasks.org"))
(defvar school-tasks-mail 
  (concat phd-thesis-org-files-dir "/school_tasks.org"))
(defvar seminar-tasks-mail 
  (concat seminar-org-files-dir "/seminar_tasks.org"))
(defvar ta-tasks-mail 
  (concat ta-org-files-dir "/current_tasks.org"))

(use-package beacon)

(setq inhibit-startup-message t)

(scroll-bar-mode -1)               ; Disable visible scrollbar
(tool-bar-mode -1)                 ; Disable the toolbar
(tooltip-mode -1)                  ; Disable tooltips
(set-fringe-mode 10)               ; Give some breathing room

(menu-bar-mode -1)                 ; Disable the menu bar
(desktop-save-mode 1)              ; Store sessions
(beacon-mode 1)                    ; Enable beacon

(server-start)                     ; Start server
(setq process-connection-type nil) ; Use pipes
(setq history-length 25)
(savehist-mode 1)
(save-place-mode 1)
(setq use-dialog-box nil)

;; Set up the visible bell
(setq visible-bell t)

(column-number-mode)
(global-display-line-numbers-mode t)

;; Set frame transparency
(set-frame-parameter (selected-frame) 'alpha efs/frame-transparency)
(add-to-list 'default-frame-alist `(alpha . ,efs/frame-transparency))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package dashboard
  :ensure t
  :diminish dashboard-mode
  :config
  (setq dashboard-banner-logo-title "Welcome to Emacs!")
  (setq dashboard-startup-banner "~/Pictures/Wallpapers/figures/480px-EmacsIcon.svg.png")
  (setq dashboard-items '((recents  . 10)
                          (bookmarks . 10)))
  (dashboard-setup-startup-hook))

(set-face-attribute 'default nil :font "Fira Code Retina" :height efs/default-font-size)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height efs/default-font-size)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height efs/default-variable-font-size :weight 'regular)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-i") 'evil-jump-forward)
(global-set-key (kbd "C-o") 'evil-jump-backward)

(use-package general
  :after evil
  :config
  (general-create-definer efs/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (efs/leader-keys
    "c"  'shell-command
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")
    "e" '(lambda () (interactive) (find-file (expand-file-name "~/.emacs.d/Emacs.org")))
    "m" '(lambda () (interactive) (mu4e))
    "r" '(lambda () (interactive) (org-capture nil))))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package command-log-mode
  :commands command-log-mode)

(use-package doom-themes
  :init (load-theme 'doom-gruvbox t))

;(use-package modus-themes
;  :ensure
;  :init
;  ;; Add all your customizations prior to loading the themes
;  (setq modus-themes-italic-constructs t
;        modus-themes-bold-constructs nil
;        modus-themes-region '(bg-only no-extend))

;  ;; Load the theme files before enabling a theme
;  (modus-themes-load-themes)
;  :config
;  ;; Load the theme of your choice:
;  ;;(modus-themes-load-operandi)
;  (modus-themes-load-vivendi)
;  :bind ("<f5>" . modus-themes-toggle))

(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))

(use-package flx)

(setq ivy-initial-inputs-alist nil)

(setq ivy-re-builders-alist
      '((t . ivy--regex-plus)))

(setq ivy-re-builders-alist
      '((t . ivy--regex-fuzzy)))

(use-package counsel
  :bind (("C-M-j" . 'counsel-switch-buffer)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (counsel-mode 1))

(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  ;; Uncomment the following line to have sorting remembered across sessions!
                                        ;(prescient-persist-mode 1)
  (ivy-prescient-mode 1))

(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package hydra
  :defer t)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(efs/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)))

  (push '("conf-unix" . conf-unix) org-src-lang-modes))

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

(use-package org
  :pin org
  :commands (org-capture org-agenda)
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-agenda-files
        '("~/.emacs.d/Org-Files/Tasks.org"
          "~/.emacs.d/Org-Files/Habits.org"
          "~/.emacs.d/Org-Files/Birthdays.org"))

  (require 'org-habit)
  (require 'org-protocol)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)

  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
          (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-refile-targets
        '(("Archive.org" :maxlevel . 1)
          ("Tasks.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (setq org-tag-alist
        '((:startgroup)
                                        ; Put mutually exclusive tags here
          (:endgroup)
          ("@errand" . ?E)
          ("@home" . ?H)
          ("@work" . ?W)
          ("agenda" . ?a)
          ("planning" . ?p)
          ("publish" . ?P)
          ("batch" . ?b)
          ("note" . ?n)
          ("idea" . ?i)))

  ;; Configure custom agenda views
  (setq org-agenda-custom-commands
        '(("d" "Dashboard"
           ((agenda "" ((org-deadline-warning-days 7)))
            (todo "NEXT"
                  ((org-agenda-overriding-header "Next Tasks")))
            (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

          ("n" "Next Tasks"
           ((todo "NEXT"
                  ((org-agenda-overriding-header "Next Tasks")))))

          ("W" "Work Tasks" tags-todo "+work-email")

          ;; Low-effort next actions
          ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
           ((org-agenda-overriding-header "Low Effort Tasks")
            (org-agenda-max-todos 20)
            (org-agenda-files org-agenda-files)))

          ("w" "Workflow Status"
           ((todo "WAIT"
                  ((org-agenda-overriding-header "Waiting on External")
                   (org-agenda-files org-agenda-files)))
            (todo "REVIEW"
                  ((org-agenda-overriding-header "In Review")
                   (org-agenda-files org-agenda-files)))
            (todo "PLAN"
                  ((org-agenda-overriding-header "In Planning")
                   (org-agenda-todo-list-sublevels nil)
                   (org-agenda-files org-agenda-files)))
            (todo "BACKLOG"
                  ((org-agenda-overriding-header "Project Backlog")
                   (org-agenda-todo-list-sublevels nil)
                   (org-agenda-files org-agenda-files)))
            (todo "READY"
                  ((org-agenda-overriding-header "Ready for Work")
                   (org-agenda-files org-agenda-files)))
            (todo "ACTIVE"
                  ((org-agenda-overriding-header "Active Projects")
                   (org-agenda-files org-agenda-files)))
            (todo "COMPLETED"
                  ((org-agenda-overriding-header "Completed Projects")
                   (org-agenda-files org-agenda-files)))
            (todo "CANC"
                  ((org-agenda-overriding-header "Cancelled Projects")
                   (org-agenda-files org-agenda-files)))))))

  (setq org-capture-templates
        `(("m" "Email Capture")
          ("mr" "Research Tasks" entry
           (file+olp research-tasks-mail "Captured Email")
           "* TODO Check this email %a"
           :immediate-finish t)
          ("ml" "Lunch Tasks" entry
           (file+olp lunch-tasks-mail "Captured Email")
           "* TODO Check this email %a"
           :immediate-finish t)
          ("ms" "SCC Project Tasks" entry
           (file+olp scc-tasks-mail "Captured Email")
           "* TODO Check this email %a"
           :immediate-finish t)
          ("mc" "School Tasks" entry
           (file+olp school-tasks-mail "Captured Email")
           "* TODO Check this email %a"
           :immediate-finish t)
          ("me" "Seminar Tasks" entry
           (file+olp seminar-tasks-mail "Captured Email")
           "* TODO Check this email %a"
           :immediate-finish t)
          ("mt" "TA Tasks" entry
           (file+olp ta-tasks-mail "Captured Email")
           "* TODO Check this email %a"
           :immediate-finish t)))

  (define-key global-map (kbd "C-c s")
    (lambda () (interactive) (mark-whole-buffer) (org-sort-entries nil ?o)))

  (define-key global-map (kbd "C-c c")
    (lambda () (interactive) (org-todo "COMPLETED")))

  (define-key global-map (kbd "C-c t")
    (lambda () (interactive) (org-todo "TODO")))

  (defun auto/SortTODO ()
    (when (and buffer-file-name (string-match ".*/todolist.org" (buffer-file-name)))
      (setq unread-command-events (listify-key-sequence "\C-c s"))))

  ;; TODO: keep working on this one
  ;;(add-hook 'buffer-list-update-hook #'auto/SortTODO)

  (efs/org-font-setup))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

(with-eval-after-load 'org
  ;; This is needed as of Org 9.2
  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python")))

;; Automatically tangle our Emacs.org config file when we save it
(defun efs/org-babel-tangle-config ()
  (when (string-equal (file-name-directory (buffer-file-name))
                      (expand-file-name user-emacs-directory))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-l")
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy
  :after lsp)

(use-package dap-mode
  ;; Uncomment the config below if you want all UI panes to be hidden by default!
  ;; :custom
  ;; (lsp-enable-dap-auto-configure nil)
  ;; :config
  ;; (dap-ui-mode 1)
  :commands dap-debug
  :config
  ;; Set up Node debugging
  (require 'dap-node)
  (dap-node-setup) ;; Automatically installs Node debug adapter if needed

  ;; Bind `C-c l d` to `dap-hydra` for easy access
  (general-define-key
   :keymaps 'lsp-mode-map
   :prefix lsp-keymap-prefix
   "d" '(dap-hydra t :wk "debugger")))

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(add-hook 'tex-mode-hook 'lsp)

(use-package python-mode
  :ensure t
  :hook (python-mode . lsp-deferred)
  :custom
  ;; NOTE: Set these if Python 3 is called "python3" on your system!
  ;; (python-shell-interpreter "python3")
  ;; (dap-python-executable "python3")
  (dap-python-debugger 'debugpy)
  :config
  (require 'dap-python))

(use-package pyvenv
  :after python-mode
  :config
  (pyvenv-mode 1))

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
              ("<tab>" . company-complete-selection))
  (:map lsp-mode-map
        ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/Documents/GithubProjects")
    (setq projectile-project-search-path '("~/Documents/GithubProjects")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :after projectile
  :config (counsel-projectile-mode))

(use-package magit
  :commands magit-status
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; NOTE: Make sure to configure a GitHub token before using this package!
;; - https://magit.vc/manual/forge/Token-Creation.html#Token-Creation
;; - https://magit.vc/manual/ghub/Getting-Started.html#Getting-Started
(use-package forge
  :after magit)

(use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package term
  :commands term
  :config
  (setq explicit-shell-file-name "bash") ;; Change this to zsh, etc
  ;;(setq explicit-zsh-args '())         ;; Use 'explicit-<shell>-args for shell-specific args

  ;; Match the default Bash shell prompt.  Update this if you have a custom prompt
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(when (eq system-type 'windows-nt)
  (setq explicit-shell-file-name "powershell.exe")
  (setq explicit-powershell.exe-args '()))

(defun efs/configure-eshell ()
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  ;; Bind some useful keys for evil-mode
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "C-r") 'counsel-esh-history)
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "<home>") 'eshell-bol)
  (evil-normalize-keymaps)

  (setq eshell-history-size         10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(use-package eshell-git-prompt
  :after eshell)

(use-package eshell
  :hook (eshell-first-time-mode . efs/configure-eshell)
  :config

  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t)
    (setq eshell-visual-commands '("htop" "zsh" "vim")))

  (eshell-git-prompt-use-theme 'powerline))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer))

(use-package dired-single
  :commands (dired dired-jump))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-open
  :commands (dired dired-jump)
  :config
  ;; Doesn't work as expected!
  ;;(add-to-list 'dired-open-functions #'dired-open-xdg t)
  (setq dired-open-extensions '(("png" . "feh")
                                ("mkv" . "mpv"))))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "H" 'dired-hide-dotfiles-mode))

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))

(use-package yasnippet
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-global-mode 1))

(use-package yasnippet-snippets)

(defun my-yas-try-expanding-auto-snippets ()
  (when yas-minor-mode
    (let ((yas-buffer-local-condition ''(require-snippet-condition . auto)))
      (yas-expand))))

(add-hook 'post-command-hook #'my-yas-try-expanding-auto-snippets)

(defun yasnippet/aux_add_cmd (file_name cmd_path prefix_entry prefix_output input)
  (let* ((curr_dir default-directory)
         (curr_file (concat curr_dir file_name))
         (curr_file_path (replace-regexp-in-string " " "\\\\ " curr_file)))
    (progn
      (if (not (file-exists-p curr_file)) (shell-command (concat "touch " curr_file_path)))
      (let* ((add_cmd (concat cmd_path curr_file_path " "))
             (_args (split-string input ","))
             (first_arg (car _args))
             (args (mapconcat (lambda (x) (concat "\'" x "\'")) _args " "))
             (command
              (concat "if ! grep " curr_file prefix_entry first_arg "}\'; then " add_cmd args "; fi")))
        (shell-command command)
        (concat prefix_output first_arg "}")))))

(use-package hide-mode-line)

(defun efs/presentation-setup ()
  (setq text-scale-mode-amount 3)
  (hide-mode-line-mode 1)
  (org-display-inline-images)
  (text-scale-mode 1))

(defun efs/presentation-end ()
  (hide-mode-line-mode 0)
  (text-scale-mode 0))

(use-package org-tree-slide
  :hook ((org-tree-slide-play . efs/presentation-setup)
         (org-tree-slide-stop . efs/presentation-end))
  :custom
  (org-tree-slide-slide-in-effect t)
  (org-tree-slide-activate-message "Presentation started!")
  (org-tree-slide-deactivate-message "Presentation finished!")
  (org-tree-slide-header t)
  (org-tree-slide-breadcrumbs " // ")
  (org-image-actual-width nil))

(use-package simpleclip
  :config
  (simpleclip-mode 1))

(setq-default mode-line-format '(
                                 "%e"
                                 (:eval
                                  (if (equal (shell-command-to-string
                                              "ps aux | grep 'mbsync -a' | wc -l") "3\n")
                                      "Running mbsync" ""))
                                 (:eval
                                  (doom-modeline-format--main))))

(use-package tex
  :ensure auctex
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil))

(use-package mu4e
  :ensure nil
  :straight (
             :host github
             :files ("build/mu4e/*.el")
             :repo "djcb/mu"
             :pre-build (("./autogen.sh") ("ninja" "-C" "build")))
  ;; :load-path "/usr/share/emacs/site-lisp/mu4e/"
  ;; :defer 20 ; Wait until 20 seconds after startup
  :config
  (require 'mu4e-org)

  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (setq mu4e-change-filenames-when-moving t)

  ;; Just plain text
  (with-eval-after-load "mm-decode"
    (add-to-list 'mm-discouraged-alternatives "text/html")
    (add-to-list 'mm-discouraged-alternatives "text/richtext"))

  (defun jcs-view-in-eww (msg)
    (eww-browse-url (concat "file://" (mu4e~write-body-to-html msg))))
  (add-to-list 'mu4e-view-actions '("Eww view" . jcs-view-in-eww) t)

  (setq mu4e-update-interval 600)
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-maildir "~/Mail")

  (defun refile-func (msg)
    (cond
     ((mu4e-message-contact-field-matches msg :to "kapur@cs.unm.edu")
      "/unm/Prof. Kapur")
     ((mu4e-message-contact-field-matches msg :from "kapur@cs.unm.edu")
      "/unm/Prof. Kapur")
     ((mu4e-message-contact-field-matches msg :cc "kapur@cs.unm.edu")
      "/unm/Prof. Kapur")
     (t "/unm/Archive")))

  (setq mu4e-contexts
        (list
         ;; School account
         (make-mu4e-context
          :name "School"
          :match-func
          (lambda (msg)
            (when msg
              (string-prefix-p "/unm" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address  . "jabelcastellanosjoo@unm.edu")
                  (user-full-name     . "Jose Abel Castellanos Joo")
                  (mu4e-drafts-folder . "/unm/Drafts")
                  (mu4e-sent-folder   . "/unm/Sent")
                  (mu4e-refile-folder . refile-func)
                  (mu4e-trash-folder  . "/unm/Trash")
                  (smtpmail-smtp-server . "smtp.office365.com")
                  (smtpmail-smtp-service . 587)
                  (smtpmail-stream-type . starttls)))
         ;; School CS department account
         (make-mu4e-context
          :name "CS department"
          :match-func
          (lambda (msg)
            (when msg
              (string-prefix-p "/cs-unm" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address  . "jose.castellanosjoo@cs.unm.edu")
                  (user-full-name     . "Jose Abel Castellanos Joo")
                  (mu4e-drafts-folder . "/cs-unm/Drafts")
                  ;;(mu4e-sent-folder   . "/cs-unm/Sent")
                  (mu4e-refile-folder . "/cs-unm/Inbox")
                  (mu4e-trash-folder  . "/cs-unm/Trash")
                  (smtpmail-smtp-server . "snape.cs.unm.edu")
                  (smtpmail-smtp-service . 1200)
                  (smtpmail-stream-type . starttls)))))

  (setq mu4e-context-policy 'pick-first)

  (setq mu4e-maildir-shortcuts
        '(("/unm/Inbox" . ?i)
          ("/unm/Sent"  . ?s)
          ("/unm/Trash" . ?t)
          ("/unm/Drafts". ?d)
          ("/unm/Prof. Kapur". ?k)
          ("/unm/Prof. Kapur/Side projects/Seminars/Beihang University". ?b)
          ("/unm/TA Work/CS 429-529". ?m)
          ("/unm/You got a Package!". ?p)
          ("/unm/Archive". ?a)
          ("/cs-unm/Inbox". ?I)
          ("/cs-unm/Trash". ?T)
          ("/cs-unm/Drafts". ?D))))

(setq mu4e-use-fancy-chars t)
(setq message-send-mail-function 'smtpmail-send-it)
(setq mu4e-attachment-dir  "~/Downloads")
(setq mu4e-headers-show-threads nil)
(setq mu4e-confirm-quit nil)
(setq mu4e-headers-results-limit -1)
(setq mu4e-compose-signature "Best,\nJose")
(setq message-citation-line-format "On %d %b %Y at %R, %f wrote:\n")
(setq message-citation-line-function 'message-insert-formatted-citation-line)
(setq
 ;; Display
 mu4e-view-show-addresses t
 mu4e-view-show-images t
 mu4e-view-image-max-width 800
 mu4e-hide-index-messages t)

;; (add-to-list 'mu4e-header-info-custom
;;              '(:acctshortname . (:name "Account short name"
;;                                        :shortname "Acct"
;;                                        :help "3 first letter of related root maildir"
;;                                        :function (lambda (msg)
;;                                                    (let ((account-name (or (mu4e-message-field msg :maildir) "")))
;;                                                      (if (equal account-name "")
;;                                                          ""
;;                                                        (substring
;;                                                         (replace-regexp-in-string "^/\\(\\w+\\)/.*$" "\\1" account-name)
;;                                                         0 3)))))))
(add-to-list 'mu4e-header-info-custom
             '(:foldername . (:name "Folder information"
                                    :shortname "Folder"
                                    :help "Message short storage information"
                                    :function (lambda (msg)
                                                (let ((shortaccount)
                                                      (maildir (or (mu4e-message-field msg :maildir) ""))
                                                      (mailinglist (or (mu4e-message-field msg :mailing-list) "")))
                                                  (if (not (equal mailinglist ""))
                                                      (setq mailinglist (mu4e-get-mailing-list-shortname mailinglist)))
                                                  (when (not (equal maildir ""))
                                                    (setq shortaccount
                                                          (substring
                                                           (replace-regexp-in-string "^/\\(\\w+\\)/.*$" "\\1" maildir)
                                                           0 3))
                                                    (setq maildir (replace-regexp-in-string ".*/\\([^/]+\\)$" "\\1" maildir))
                                                    (if (> (length maildir) 8)
                                                        (setq maildir (concat (substring maildir 0 7) "…")))
                                                    (setq maildir (concat "[" shortaccount "]" maildir)))
                                                  (cond
                                                   ((and (equal maildir "")
                                                         (not (equal mailinglist "")))
                                                    mailinglist)
                                                   ((and (not (equal maildir ""))
                                                         (equal mailinglist ""))
                                                    maildir)
                                                   ((and (not (equal maildir ""))
                                                         (not (equal mailinglist "")))
                                                    (concat maildir " (" mailinglist ")"))
                                                   (t
                                                    "")))))))

;; (add-to-list 'mu4e-header-info-custom
;;              '(:useragent . (:name "User-Agent"
;;                                    :shortname "UserAgt."
;;                                    :help "Mail client used by correspondant"
;;                                    :function ed/get-origin-mail-system-header)))
;; (add-to-list 'mu4e-header-info-custom
;;              '(:openpgp . (:name "PGP Info"
;;                                  :shortname "PGP"
;;                                  :help "OpenPGP information found in mail header"
;;                                  :function ed/get-openpgp-header)))
;; (setq mu4e-view-fi
;; elds '(:flags :maildir :mailing-list :tags :useragent :openpgp)
;; mu4e-headers-fields '((:flags         . 5)
;;                       (:human-date    . 12)
;;                                   ;(:acctshortname . 4)
;;                       (:foldername    . 25)
;;                       (:from-or-to    . 25)
;;                                   ;(:size          . 6)
;;                       (:subject       . nil))
;; mu4e-compose-hidden-headers '("^Face:" "^X-Face:" "^Openpgp:"
;;                               "^X-Draft-From:" "^X-Mailer:"
;;"^User-agent:"))

(use-package mu-cite)

(use-package org-mime
  :ensure t)

;; (use-package mu4e-thread-folding
;;   :ensure t
;;   :straight (
;;              :host github
;;              :files ("*.el")
;;              :repo "rougier/mu4e-thread-folding")
;;   :config
;;   (add-to-list 'mu4e-header-info-custom
;;                '(:empty . (:name "Empty"
;;                                  :shortname ""
;;                                  :function (lambda (msg) "  "))))
;;   (setq mu4e-headers-fields '((:empty         .    2)
;;                               (:human-date    .   12)
;;                               (:flags         .    6)
;;                               (:mailing-list  .   10)
;;                               (:from          .   22)
;;                               (:subject       .   nil))))

(use-package mu4e-dashboard
  :ensure t
  :straight (
             :host github
             :files ("*.el")
             :repo "rougier/mu4e-dashboard"))

(use-package markdown-preview-eww
  :ensure nil
  :straight (
             :host github
             :files ("*.el")
             :repo "niku/markdown-preview-eww"))

(use-package perspective
  :ensure t
  :bind (("C-x k" . persp-kill-buffer*)
         ("C-x C-b" . persp-ivy-switch-buffer))
  :init
  (persp-mode))

(use-package org-modern
  :ensure t
  :straight (
             :host github
             :files ("*.el")
             :repo "minad/org-modern")
  :config
  ;; Add frame borders and window dividers
  (modify-all-frames-parameters
   '((right-divider-width . 40)
     (internal-border-width . 40)))
  (dolist (face '(window-divider
                  window-divider-first-pixel
                  window-divider-last-pixel))
    (face-spec-reset-face face)
    (set-face-foreground face (face-attribute 'default :background)))
  (set-face-background 'fringe (face-attribute 'default :background))

  (setq
   ;; Edit settings
   org-auto-align-tags nil
   org-tags-column 0
   org-catch-invisible-edits 'show-and-error
   org-special-ctrl-a/e t
   org-insert-heading-respect-content t

   ;; Org styling, hide markup etc.
   org-hide-emphasis-markers t
   org-pretty-entities t
   org-ellipsis "…"

   ;; Agenda styling
   org-agenda-block-separator ?─
   org-agenda-time-grid
   '((daily today require-timed)
     (800 1000 1200 1400 1600 1800 2000)
     " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
   org-agenda-current-time-string
   "⭠ now ─────────────────────────────────────────────────")

  ;; Enable org-modern-mode
  (add-hook 'org-mode-hook #'org-modern-mode)
  (add-hook 'org-agenda-finalize-hook #'org-modern-agenda))
