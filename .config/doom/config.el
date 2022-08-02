;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Jose Abel Castellanos Joo"
      user-mail-address "jabelcastellanosjoo@unm.edu")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


(defvar efs/default-font-size 160)
(defvar efs/default-variable-font-size 160)
(set-face-attribute 'default nil :font "Fira Code Retina" :height efs/default-font-size)
(set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height efs/default-font-size)
(set-face-attribute 'variable-pitch nil :font "Fira Code Retina" :height efs/default-variable-font-size :weight 'regular)

(require 'mu4e)
(require 'mu4e-org)

(setq mu4e-change-filenames-when-moving t)

(with-eval-after-load "mm-decode"
  (add-to-list 'mm-discouraged-alternatives "text/html")
  (add-to-list 'mm-discouraged-alternatives "text/richtext"))

(defun jcs-view-in-eww (msg)
  (eww-browse-url (concat "file://" (mu4e~write-body-to-html msg))))
(add-to-list 'mu4e-view-actions '("Eww view" . jcs-view-in-eww) t)

(setq mu4e-update-interval 600)
(setq mu4e-get-mail-command "mbsync -a")
(setq mu4e-root-maildir "~/Mail")

(defun refile-func (msg)
  (cond
   ((mu4e-message-contact-field-matches msg :to "kapur@cs.unm.edu")
    "/unm/Prof. Kapur")
   ((mu4e-message-contact-field-matches msg :from "kapur@cs.unm.edu")
    "/unm/Prof. Kapur")
   ((mu4e-message-contact-field-matches msg :cc "kapur@cs.unm.edu")
    "/unm/Prof. Kapur")
   ((mu4e-message-contact-field-matches msg :to "kapur@unm.edu")
    "/unm/Prof. Kapur")
   ((mu4e-message-contact-field-matches msg :from "kapur@unm.edu")
    "/unm/Prof. Kapur")
   ((mu4e-message-contact-field-matches msg :cc "kapur@unm.edu")
    "/unm/Prof. Kapur")
   (t "/unm/Archive")))

(setq mu4e-contexts
      (list
                                        ; School account
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
                                        ; School CS department account
       (make-mu4e-context
        :name "CS department"
        :match-func
        (lambda (msg)
          (when msg
            (string-prefix-p "/cs-unm" (mu4e-message-field msg :maildir))))
        :vars '((user-mail-address  . "jose.castellanosjoo@cs.unm.edu")
                (user-full-name     . "Jose Abel Castellanos Joo")
                (mu4e-drafts-folder . "/cs-unm/Drafts")
                                        ;(mu4e-sent-folder   . "/cs-unm/Sent")
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
        ("/unm/TA Work/CS 241". ?c)
        ("/unm/You got a Package!". ?p)
        ("/unm/Archive". ?a)
        ("/cs-unm/Inbox". ?I)
        ("/cs-unm/Trash". ?T)
        ("/cs-unm/Drafts". ?D)))
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
                                        ; Display
 mu4e-view-show-addresses t
 mu4e-view-show-images t
 mu4e-view-image-max-width 800
 mu4e-hide-index-messages t)

(defvar phd-thesis-dir "~/Documents/GithubProjects/phd-thesis")
(defvar ta-org-files-dir 
  (concat phd-thesis-dir
          "/Documents/Semesters/Fall/2022/TA-CS-241/Org-Files"))
(defvar phd-thesis-write-ups-dir
  (concat phd-thesis-dir
          "/Documents/Write-Ups"))
(defvar phd-thesis-org-files-dir
  (concat phd-thesis-dir
          "/Documents/Org-Files"))

(defvar scc-dir 
  (concat phd-thesis-dir
          "/Documents/Side-Projects/kapur-nsf-proposal"))
(defvar scc-reports-dir (concat scc-dir "/Reports"))
(defvar scc-org-files-dir (concat scc-dir "/Org-Files"))

(defvar seminar-dir (concat phd-thesis-dir "/Documents/Seminars/BeihangUniversity-Fall2021"))
(defvar seminar-org-files-dir (concat seminar-dir "/Org-Files"))
(defvar ta-tasks-mail 
  (concat ta-org-files-dir "/current_tasks.org"))

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

;; (general-create-definer efs/leader-keys
;;   :keymaps '(normal insert visual emacs)
;;   :prefix "SPC"
;;   ;:global-prefix "C-SPC"
;;   )

;; (efs/leader-keys
;;  "e" '(:ignore t :which-key "(e)dit buffer")
;;  ;"ec"  '(evilnc-comment-or-uncomment-lines :which-key "(c)omment line")
;;  ;"ei"  '((lambda () (interactive) (indent-region (point-min) (point-max))) :which-key "(i)ndent buffer")
;;  ;"ey" '(simpleclip-copy :which-key "clipboard (y)ank")
;;  ;"ep" '(simpleclip-paste :which-key "clipboard (p)aste")
;;  "f" '(:ignore t :which-key "edit (f)iles")
;;  "fa" '((lambda () (interactive) (find-file (expand-file-name (concat phd-thesis-org-files-dir "/main.org")))) :which-key "(a)genda")
;;  "fw" '((lambda () (interactive) (find-file (expand-file-name (concat seminar-dir "/Reports/finding_certificates_qm_univariate/main.tex")))) :which-key "Current (w)ork")
;;  ;"fr" '(:ignore t :which-key "Edit (r)eferences")
;;  ;"frp" '((lambda () (interactive) (find-file (expand-file-name (concat phd-thesis-write-ups-dir "/references.bib")))) :which-key "Edit (p)hD references")
;;  ;"frs" '((lambda () (interactive) (find-file (expand-file-name (concat scc-reports-dir "/references.bib")))) :which-key "Edit (s)CC references")
;;  ;"s"  '(shell-command :which-key "(s)hell command")
;;  ;"t"  '(:ignore t :which-key "(t)oggles")
;;  ;"tt" '(counsel-load-theme :which-key "Choose (t)heme")
;;  ;"g" '(magit-status :which-key "Ma(g)it status")
;;  ;"d" '(dired-jump :which-key "(d)ired jump")
;;  ;"m" '(mu4e :which-key "(m)u4e")
;;  ;"l" '(:ignore t :which-key "(l)atex related")
;;  ;"lp" '((lambda () (interactive) (yasnippet/goto-parent-file)) :which-key "Goto (p)arent")
;;  ;"lf" '((lambda () (interactive) (LaTeX-fill-buffer nil)) :which-key "Latex (f)ill buffer")
;;  ;"lF" '((lambda () (interactive) (lsp-latex-forward-search)) :which-key "Latex (f)orward search")
;;  ;"o" '(org-capture nil :which-key "(o)rg-capture")
;;  ;"w" '(:ignore t :which-key "(w)indows related")
;;  ;"wu" '(winner-undo :which-key "Winner (u)ndo")
;;  ;"wr" '(winner-redo :which-key "Winner (r)edo")
;;  )

(setq yas-snippet-dirs '("/home/jose/.config/jose-emacs/snippets"))
(setq yas-key-syntaxes '(yas-longest-key-from-whitespace "w_.()" "w_." "w_" "w"))
;(define-key yas-minor-mode-map (kbd "C-g") 'evil-normal-state)
;(define-key yas-keymap (kbd "C-g") 'evil-normal-state)
(yas-global-mode 1)

(load "/home/jose/.config/jose-emacs/snippets/yasnippet-scripts.el")
