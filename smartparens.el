(smartparens-global-strict-mode +1)
(sp-use-paredit-bindings)
(sp-pair "'" nil :actions :rem)
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
