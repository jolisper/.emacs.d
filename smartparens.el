(smartparens-global-strict-mode +1)
(sp-use-paredit-bindings)

(sp-with-modes sp--lisp-modes
  ;; disable ', it's the quote character!
  (sp-local-pair "'" nil :actions nil)
  ;; also only use the pseudo-quote inside strings where it serve as
  ;; hyperlink.
  (sp-local-pair "`" "'" :when '(sp-in-string-p sp-in-comment-p))
  (sp-local-pair "`" nil
                 :skip-match (lambda (ms mb me)
                               (cond
                                ((equal ms "'")
                                 (or (sp--org-skip-markup ms mb me)
                                     (not (sp-point-in-string-or-comment))))
                                (t (not (sp-point-in-string-or-comment)))))))

(show-smartparens-global-mode +1)

;; No bold pair match face
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(sp-show-pair-enclosing ((t nil)))
 '(sp-show-pair-match-face ((t (:background "#6F6F6F" :weight normal))))
 '(sp-show-pair-mismatch-face ((t (:background "#6F6F6F" :foreground "#DCA3A3" :weight normal)))))
