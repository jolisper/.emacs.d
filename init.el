(defun load-user-file (file)
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-emacs-directory)))

(load-user-file "menu-bar.el")
(load-user-file "company-mode.el")
(load-user-file "auto-save-and-backup-files.el")
(load-user-file "package-archives.el")
(load-user-file "smartparens.el")
(load-user-file "theme.el")
