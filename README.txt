This configuration of Emacs use 'after-init-hook' for package config. Please, create a '.emacs' file in your home directory and add the following content:

(add-hook 'after-init-hook (lambda () (load "~/.emacs.d/init.el")))

Clojure support need some extra configuration, the following is my actual .lein/profiles.clj:

{:user {:plugins [[refactor-nrepl "2.3.0-SNAPSHOT"]
                  [cider/cider-nrepl "0.12.0-SNAPSHOT"]]
        :dependencies [[org.clojure/tools.nrepl "0.2.12"]]}}

Is useful to set some aliases for the emacsclient in your .bash_profile:

alias ec='emacsclient -nc' # Create a new client instance
alias em='emacsclient -nt' # Use an existing client instance

Enjoy!
