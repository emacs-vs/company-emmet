;;; company-emmet.el --- Company completion for emmet  -*- lexical-binding: t; -*-

;; Copyright (C) 2023-2026 Shen, Jen-Chieh

;; Author: Shen, Jen-Chieh <jcs090218@gmail.com>
;; Maintainer: Shen, Jen-Chieh <jcs090218@gmail.com>
;; URL: https://github.com/emacs-vs/company-emmet
;; Version: 0.1.0
;; Package-Requires: ((emacs "26.1") (company "0.8.0") (emmet-mode "1.0.10"))
;; Keywords: convenience emmet company

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Company completion for emmet
;;

;;; Code:

(require 'company)
(require 'emmet-mode)

(defgroup company-emmet nil
  "Company completion for Emmet."
  :prefix "company-emmet-"
  :group 'tool
  :link '(url-link :tag "Repository" "https://github.com/emacs-vs/company-emmet"))

(defun company-emmet--candidate ()
  "Return the candidate!"
  (car (emmet-expr-on-line)))

(defun company-emmet--prefix ()
  "Return the candidate!"
  (company-emmet--candidate))

(defun company-emmet--doc-buffer (candidate)
  "Return document for CANDIDATE."
  (company-doc-buffer
   (emmet-transform candidate)))

;;;###autoload
(defun company-emmet (command &optional arg &rest _ignored)
  "Company backend for Emmet.

Arguments COMMAND, ARG and IGNORED are standard arguments from `company-mode`."
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-emmet))
    (prefix (company-emmet--prefix))
    (candidates (list (company-emmet--candidate)))
    (doc-buffer (company-emmet--doc-buffer arg))
    (post-completion
     (delete-region (- (point) (length (company-emmet--prefix))) (point))
     (insert arg)
     (call-interactively #'emmet-expand-line))))

(provide 'company-emmet)
;;; company-emmet.el ends here
