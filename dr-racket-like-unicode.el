;;; dr-racket-like-unicode.el --- An Emacs implementation of DrRacket's unicode input  -*- lexical-binding: t; -*-

;; Copyright (C) 2016  David Christiansen

;; Author: David Christiansen <david@davidchristiansen.dk>
;; Keywords: i18n, tools

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This is an implementation of DrRacket-style Unicode input.  The
;; difference between this and an Emacs input method is that an Emacs
;; input method attempts to transform text as it is typed, while this
;; minor mode simply provides a command that turns the current
;; TeX-syntax symbol into its Unicode equivalent.

;;; Code:

(defgroup dr-racket-like-unicode
  '()
  "Input Unicode characters as is done in DrRacket."
  :group 'editing)

(defcustom dr-racket-like-unicode-table
  '(("\\vdash"      . "⊢")
    ("\\to"         . "→")
    ("\\rightarrow" . "→")
    ("\\Rightarrow" . "⇒")
    ("\\leftarrow"  . "←")
    ("\\Leftarrow"  . "⇐")
    ("\\cdot"       . "·")
    ("\\circ"       . "∘")
    ("\\prime"      . "′")
    ("\\alpha"      . "α")
    ("\\beta"       . "β")
    ("\\gamma"      . "γ")
    ("\\delta"      . "δ")
    ("\\epsilon"    . "ε")
    ("\\zeta"       . "ζ")
    ("\\eta"        . "η")
    ("\\theta"      . "θ")
    ("\\iota"       . "ι")
    ("\\kappa"      . "κ")
    ("\\lambda"     . "λ")
    ("\\mu"         . "μ")
    ("\\nu"         . "ν")
    ("\\xi"         . "ξ")
    ("\\omicron"    . "ο")
    ("\\pi"         . "π")
    ("\\rho"        . "ρ")
    ("\\sigma"      . "σ")
    ("\\tau"        . "τ")
    ("\\upsilon"    . "υ")
    ("\\phi"        . "φ")
    ("\\chi"        . "χ")
    ("\\psi"        . "ψ")
    ("\\omega"      . "ω")
    ("\\Alpha"      . "Α")
    ("\\Beta"       . "Β")
    ("\\Gamma"      . "Γ")
    ("\\Delta"      . "Δ")
    ("\\Epsilon"    . "Ε")
    ("\\Zeta"       . "Ζ")
    ("\\Eta"        . "Η")
    ("\\Theta"      . "Θ")
    ("\\Iota"       . "Ι")
    ("\\Kappa"      . "Κ")
    ("\\Lambda"     . "Λ")
    ("\\Mu"         . "Μ")
    ("\\Nu"         . "Ν")
    ("\\Xi"         . "Ξ")
    ("\\Omicron"    . "Ο")
    ("\\Pi"         . "Π")
    ("\\Rho"        . "Ρ")
    ("\\Sigma"      . "Σ")
    ("\\Tau"        . "Τ")
    ("\\Upsilon"    . "Υ")
    ("\\Phi"        . "Φ")
    ("\\Chi"        . "Χ")
    ("\\Psi"        . "Ψ")
    ("\\Omega"      . "Ω")
    ("\\o"          . "ø")
    ("\\O"          . "Ø")
    ("\\ae"         . "æ")
    ("\\AE"         . "Æ")
    ("\\aa"         . "å")
    ("\\AA"         . "Å")
    ("\\\"a"        . "ä")
    ("\\\"o"        . "ö")
    ("\\\"u"        . "ü")
    ("\\\"y"        . "ÿ")
    ("\\\"i"        . "ï")
    ("\\\"e"        . "ë"))
  "The table of operators for `dr-racket-like-unicode-char'."
  :type 'alist
  :group 'dr-racket-like-unicode)

(defun dr-racket-like-unicode-char ()
  "Transform the TeX-style code immediately prior to point into Unicode.

Customize `dr-racket-like-unicode-table' to change the collection of unicode symbols."
  (interactive)
  (let ((ok-p (looking-back "\\\\[a-zA-Z]+" 50)))
    (if (not ok-p)
        (error "No character code immediately before point")
      (let ((code (match-string 0))
            (start (match-beginning 0))
            (end (match-end 0)))
        (let ((unicode (assoc code dr-racket-like-unicode-table)))
          (if unicode
              (progn (delete-region start end)
                     (goto-char start)
                     (insert (cdr unicode)))
            (message "Don't understand `%s' as a Unicode abbreviation." code)))))))


(defvar dr-racket-like-unicode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c \\") 'dr-racket-like-unicode-char)
    map))

(define-minor-mode dr-racket-like-unicode-mode
  "A minor mode for writing Unicode as in DrDr-Racket.

This minor mode binds one command: `dr-racket-like-unicode-char'.

\\{dr-racket-like-unicode-map}"
  nil
  "Dr\\"
  dr-racket-like-unicode-map)

(provide 'dr-racket-like-unicode)
;;; dr-racket-like-unicode.el ends here
