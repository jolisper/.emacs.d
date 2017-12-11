(autoload 'dtrace-script-mode "dtrace-script-mode" () t)
(add-to-list 'auto-mode-alist '("\\.d\\'" . dtrace-script-mode))

(add-hook 'dtrace-script-mode-hook 'imenu-add-menubar-index)
(add-hook 'dtrace-script-mode-hook 'font-lock-mode)
