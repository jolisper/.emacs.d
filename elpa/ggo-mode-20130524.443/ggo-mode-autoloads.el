;;; ggo-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "ggo-mode" "ggo-mode.el" (22749 54452 0 0))
;;; Generated autoloads from ggo-mode.el

(autoload 'ggo-mode "ggo-mode" "\
Major mode for editing gengetopt files.

\\[ggo-skeleton] inserts the basic .ggo data.

\\[ggo-insert-option-skeleton] inserts an option and parameters at the
point.

The `argtype' field includes `enum', which indicates a string
field, but complies with the requirements of the `values'
keyword.

\\{ggo-mode-map}

\(fn)" t nil)

(autoload 'ggo-skeleton "ggo-mode" "\
Skeleton for Gengetopt files.

\(fn &optional STR ARG)" t nil)

(add-to-list 'auto-mode-alist '("\\.ggo\\'" . ggo-mode))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; ggo-mode-autoloads.el ends here
