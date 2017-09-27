(add-hook 'eshell-mode-hook
	  (lambda ()
	    (progn 
	      (add-to-list 'eshell-visual-commands "htop")
	      (setq eshell-destroy-buffer-when-process-dies 1))))
