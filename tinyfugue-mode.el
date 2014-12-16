;;; tinyfugue-mode.el --- Major mode for tinyfugue, the mud client.

;; Copyright (C) 2001  Free Software Foundation, Inc.
;; Copyright (C) 2013 Johann "Myrkraverk" Oskarsson 

;; Authors: Johann "Myrkraverk" Oskarssson & StefanMonnier
;; Keywords: extensions, mud, tinyfugue

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; Based on Sample mode, found on the EmacsWiki.

;;; Installation:

;; With tinyfugue-mode.el somewhere in your load path, put this in
;; your init.el (or .emacs):

;; (autoload 'tinyfugue-mode "tinyfugue-mode" "TinyFugue editing mode" t)
;; (add-to-list 'auto-mode-alist '("\\.tf$" . tinyfugue-mode))
;; (add-to-list 'auto-mode-alist '("\\.tfrc$" . tinyfugue-mode))

;; 

;;; Code:

(defvar tinyfugue-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map [foo] 'tinyfugue-do-foo)
    map)
  "Keymap for `tinyfugue-mode'.")

(defvar tinyfugue-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?_ "w" st) ; simpler to add _ to words rather
				    ; than use symbols
    st)
  "Syntax table for `tinyfugue-mode'.")

(defvar tinyfugue-font-lock-keywords
  '(
    ("^\\([;#].*\\)$" (1 font-lock-comment-face))
    ("^/\\(\\sw+\\)" (1 font-lock-function-name-face))
    )
  "Keyword highlighting specification for `tinyfugue-mode'.")

;(defvar tinyfugue-imenu-generic-expression
;  ...)

;(defvar tinyfugue-outline-regexp
;  ...)

 ;;;###autoload
(define-derived-mode tinyfugue-mode fundamental-mode "Tinyfugue"
  "A major mode for editing Tinyfugue files."
  :syntax-table tinyfugue-mode-syntax-table
  (set (make-local-variable 'comment-start) "; ")
  (set (make-local-variable 'comment-start-skip) ";+\\s-*")
  (set (make-local-variable 'font-lock-defaults)
       '(tinyfugue-font-lock-keywords))
  (set (make-local-variable 'indent-line-function) 'tinyfugue-indent-line)
;  (set (make-local-variable 'imenu-generic-expression)
;       tinyfugue-imenu-generic-expression)
;  (set (make-local-variable 'outline-regexp) tinyfugue-outline-regexp)
  )

;  ...)

 ;;; Indentation

(defun tinyfugue-indent-line ()
  "Indent current line of Tinyfugue code."
  (interactive)

  (let ((savep (> (current-column) (current-indentation)))
	(indent (condition-case nil (max (tinyfugue-calculate-indentation) 0)
		  (error 0))))
    (if savep
	(save-excursion (indent-line-to indent))
      (indent-line-to indent))))

(defun tinyfugue-calculate-indentation ()
  "Return the column to which the current line should be indented."

  (save-excursion
    (forward-line -1)
    (end-of-line)
    (if (char= (char-before) ?\\)
	4
      0)
    ); (save-excursion
  )


(provide 'tinyfugue)
;;; tinyfugue-mode.el ends her
