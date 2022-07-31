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
