;; Requirements:
;; brew tap homebrew/science
;; brew install Caskroom/cask/xquartz
;; brew install r

(custom-set-variables
 '(org-babel-load-languages
   (quote ((emacs-lisp . t)
	   (R . t)
	   (ruby . t))))
 '(org-confirm-babel-evaluate nil))
