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
  ; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")
  ; Call Gofmt before saving                                                    
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))
  ; Godef jump key binding                                                      
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark))

(add-hook 'go-mode-hook 'my-go-mode-hook)

;; Go Autocomplete
;; go get -u github.com/nsf/gocode
(require 'company-go)
(add-hook 'go-mode-hook 'company-mode)
(add-hook 'go-mode-hook (lambda ()
  (set (make-local-variable 'company-backends) '(company-go))
  (company-mode)))

;; Guru
(require 'go-guru)
(add-hook 'go-mode-hook #'go-guru-hl-identifier-mode)

;; Go eldoc
(require 'go-eldoc)
(add-hook 'go-mode-hook 'go-eldoc-setup)

;; Smartparents

;; for i := range x {<cursor>} to
;; for i := range x {
;;    <cursor>
;; }
;; when hits RET
(sp-local-pair 'go-mode "{" nil :post-handlers '(("||\n[i]" "RET")))

;; Flycheck on Golang files
(add-hook 'go-mode-hook 'flycheck-mode)
