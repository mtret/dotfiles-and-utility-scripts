;hide annoying elements
(setq inhibit-startup-message t) 
(setq initial-scratch-message nil)
(setq make-backup-files nil) 
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; line numbering and stuff
(line-number-mode 1)
(column-number-mode 1)
(global-hl-line-mode 1)
(global-linum-mode t)
(set-default-font "Terminus (TTF) Medium 9")

;;window size
(if (window-system)
    (set-frame-height (selected-frame) 65)
)

;;MELPA
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . l)))
(package-initialize)

;;require packages that are not already installed
(mapc
 (lambda (package)
   (unless (package-installed-p package)
     (progn (message "installing %s" package)
            (package-refresh-contents)
            (package-install package))))
 '(php-mode
   material-theme
   monokai-theme
   flycheck
   org
   expand-region
   projectile
   magit
   flx-ido
   dashboard
   key-chord
   dumb-jump
   )
 )

;;theme
(load-theme 'material t)

;;Intellij-like smart expand
(require 'expand-region)

;;CUA
(cua-mode 1)
(global-set-key (kbd "C-q") 'er/expand-region)

;;go to definition
(dumb-jump-mode 1)

;;dashboard
(require 'dashboard)
(dashboard-setup-startup-hook)

;;projectile
(projectile-global-mode)
(setq projectile-enable-caching t)
