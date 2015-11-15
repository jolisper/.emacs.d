(when (eq system-type 'darwin)
  (setq mac-option-key-is-meta nil
	mac-command-key-is-meta t
	mac-command-modifier 'meta
	mac-option-modifier 'none)
  (set-face-attribute 'default nil
		      :family "Monaco" :height 120 :weight 'normal)
  (setq ring-bell-function #'ignore))
