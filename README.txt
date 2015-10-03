This configuration of Emacs use 'after-init-hook' for package config. Please, create a '.emacs' file in your home directory and add the following content:

(add-hook 'after-init-hook (lambda () (load "~/.emacs.d/init.el")))

Enjoy!
