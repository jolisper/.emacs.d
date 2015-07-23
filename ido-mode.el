(ido-mode 1)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)

(global-set-key
     "\M-x"
     (lambda ()
       (interactive)
       (call-interactively
        (intern
         (ido-completing-read
          "M-x "
          (all-completions "" obarray 'commandp))))))
