;; Windows movement
(global-set-key "\C-x\C-p" 'other-window)

(defun other-window-backwards (&optional n)
  "Select nth previous window."
  (interactive "p")
  (other-window (- (prefix-numeric-value n))))

(global-key-set "\C-x\C-n" 'other-window-backwards)

;; Scrolling
(defalias 'scroll-ahead 'scroll-up)
(defalias 'scroll-behind 'scroll-down)

(defun scroll-n-line-ahead (&optional n)
  "Scroll ahead n lines (1 by default)."
  (interactive "P")
  (scroll-ahead (prefix-numeric-value n)))

(defun scroll-n-line-behind (&optional n)
  "Scroll behind n lines (1 by default)."
  (interactive "P")
  (scroll-behind (prefix-numeric-value n)))

(global-set-key "\C-q" 'scroll-n-line-behind)
(global-set-key "\C-z" 'scroll-n-line-ahead)

;; Cursor movement
(defun point-to-top ()
  "Put point on top line window."
  (interactive)
  (move-to-window-line 0))

(defun point-to-bottom ()
  "Put point at beginning of last visible line."
  (interactive)
  (move-to-window-line -1))

(global-set-key "\M-p" 'point-to-top)
(global-set-key "\M-n" 'point-to-bottom)

;; Handle symlink - read only (hooks)
(defun read-only-if-symlink ()
  (if (file-symlink-p buffer-file-name)
      (progn
	(setq buffer-read-only t)
	(message "File is a symlink"))))

(add-hook 'find-file-hooks 'read-only-if-symlink)

(defun visit-target-instead ()
  "Replace this buffer with a buffer visiting the link target."
  (interactive)
  (if buffer-file-name
      (let ((target (file-symlink-p buffer-file-name)))
	(if target
	    (find-alternate-file target)
	  (error "Not visiting a symlink")))
    (error "Not visiting a file")))

(defun clobber-symlink ()
  "Replace symlink with a copy of the file."
  (interactive)
  (if buffer-file-name
      (let ((target (file-symlink-p buffer-file-name)))
	(if target
	    (if (yes-or-no-p (format "Replace %s with %s?"
				     buffer-file-name
				     target))
		(progn
		  (delete-file buffer-file-name)
		  (write-file buffer-file-name)))
	  (error "Not visiting a symlink")))
    (error "Not visiting a file")))

(defadvice switch-to-buffer
    (before existing-buffer activate compile)
  "When interactive, switch to existing buffers only,
unless given a prefix argument."
  (interactive
   (list (read-buffer "Switch to buffer: "
		      (other-buffer)
		      (null current-prefix-arg)))))

;; Undo scroll
(defvar unscroll-point (make-marker)
  "Text position for the next call to 'unscroll'.")

(defvar unscroll-window-start (make-marker)
  "Window start for next call to 'unscroll'.")

(defvar unscroll-hscroll nil
  "Hscroll for next call to 'unscroll'.")

(put 'scroll-up 'unscrollable t)
(put 'scroll-down 'unscrollable t)
(put 'scroll-left 'unscrollable t)
(put 'scroll-right 'unscrollable t)

(defun unscroll-maybe-remember ()
  (if (not (get last-command 'unscrollable))
      (progn
	(set-marker unscroll-point (point))
	(set-marker unscroll-window-start (window-start))
	(setq unscroll-hscroll (window-hscroll)))))

(defadvice scroll-up
    (before remember-for-unscroll activate compile)
  "Remember where we started from, for 'unscroll'."
  (unscroll-maybe-remember))

(defadvice scroll-down
    (before remember-for-unscroll activate compile)
  "Remember where we started from, for 'unscroll'."
  (unscroll-maybe-remember))

(defadvice scroll-left
    (before remember-for-unscroll activate compile)
  "Remember where we started from, for 'unscroll'."
  (unscroll-maybe-remember))

(defadvice scroll-right
    (before remember-for-unscroll activate compile)
  "Remember where we started from, for 'unscroll'."
  (unscroll-maybe-remember))

(defun unscroll ()
  "Jump to location specified by 'unscroll-point'."
  (interactive)
  (goto-char unscroll-point)
  (set-window-start nil unscroll-window-start)
  (set-window-hscroll nil unscroll-hscroll))
