This configuration of Emacs use 'after-init-hook' for package config. Please, create a '.emacs' file in your home directory and add the following content:

(add-hook 'after-init-hook (lambda () (load "~/.emacs.d/init.el")))

Clojure support need some extra configuration, the is following my actual .lein/profiles.clj:

{:user {:plugins [[refactor-nrepl "2.0.0-SNAPSHOT"]
                  [cider/cider-nrepl "0.10.0"]]
        :dependencies [[org.clojure/tools.nrepl "0.2.12"]]}}

Enjoy!
