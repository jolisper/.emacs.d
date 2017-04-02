(setq go-path (string-trim (shell-command-to-string "go env GOPATH")))
(setq go-bin-path (string-join `(,go-path "/bin")))

(setenv "GOPATH" go-path)
(setenv "PATH" (concat (getenv "PATH") ":" go-bin-path))

(add-to-list 'exec-path go-bin-path)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))


;; Go doc config
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

;; Go format before save
(defun my-go-mode-hook ()
  ; Call Gofmt before saving                                                    
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Godef jump key binding                                                      
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark))

(add-hook 'go-mode-hook 'my-go-mode-hook)

;; Go Autocomplete
;; go get -u github.com/nsf/gocode
(defun auto-complete-for-go ()
  (auto-complete-mode 1))

(add-hook 'go-mode-hook 'auto-complete-for-go)

(with-eval-after-load 'go-mode
   (require 'go-autocomplete))