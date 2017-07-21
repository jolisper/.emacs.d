;; From http://www.emacswiki.org/emacs/ElispCookbook#toc58
(defun directory-dirs (dir)
  "Find all directories in DIR."
  (unless (file-directory-p dir)
    (error "Not a directory `%s'" dir))
  (let ((dir (directory-file-name dir))
        (dirs '())
        (files (directory-files dir nil nil t)))
    (dolist (file files)
      (unless (member file '("." ".."))
        (let ((file (concat dir "/" file)))
          (when (file-directory-p file)
            (setq dirs (append (cons file
                                     (directory-dirs file))
                               dirs))))))
    dirs))

(setq jolisper-org-agenda-root "~/org")
(setq jolisper-org-agenda-files-list "~/org/org-agenda-list.el")

(defun jolisper-org-agenda-files-update ()
  "Create or update the `my-org-agenda-files-list' file.

This file contains elisp code to set `org-agenda-files' to a
recursive list of all children under `my-org-agenda-root'. "
  (interactive)
  (with-temp-buffer
    (insert
     ";; Warning: this file has been automatically generated\n"
     ";; by `jolisper-org-agenda-files-update'\n")
    (let ((dir-list (directory-dirs jolisper-org-agenda-root))
          (print-level nil)
          (print-length nil))
      (cl-prettyprint `(setq org-agenda-files (quote ,dir-list))))
    (write-file jolisper-org-agenda-files-list))
  (load jolisper-org-agenda-files-list))

(jolisper-org-agenda-files-update)

