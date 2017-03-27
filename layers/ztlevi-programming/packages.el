;;; packages.el --- ztlevi-ui layer packages file for Spacemacs.
;;
;; Copyright (c) 2016-2017 ztlevi
;;
;; Author: ztlevi <zhouting@umich.edu>
;; URL: https://github.com/ztlevi/Spacemacs-config
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst ztlevi-programming-packages
  '(
    flycheck
    )
  )

(defun ztlevi-programming/post-init-flycheck()
  (progn
    ;; use web-mode for .jsx files
      (add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))

      ;; disable jshint since we prefer eslint checking
      (setq-default flycheck-disabled-checkers
                    (append flycheck-disabled-checkers
                            '(javascript-jshint)))

      ;; use eslint with web-mode for jsx files
      (flycheck-add-mode 'javascript-eslint 'web-mode)

      ;; customize flycheck temp file prefix
      (setq-default flycheck-temp-prefix ".flycheck")

      ;; disable json-jsonlist checking for json files
      (setq-default flycheck-disabled-checkers
                    (append flycheck-disabled-checkers
                            '(json-jsonlist)))

      ;; add c++ flycheck standard
      (add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++11")))

      ;; https://github.com/purcell/exec-path-from-shell
      ;; only need exec-path-from-shell on OSX
      ;; this hopefully sets up path and other vars better
      (when (memq window-system '(mac ns))
        (exec-path-from-shell-initialize))

      ;; for better jsx syntax-highlighting in web-mode
      (defadvice web-mode-highlight-part (around tweak-jsx activate)
        (if (equal web-mode-content-type "jsx")
            (let ((web-mode-enable-part-face nil))
              ad-do-it)
          ad-do-it))
    )
  )
