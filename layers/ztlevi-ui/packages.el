;;; packages.el --- ztlevi-ui layer packages file for Spacemacs. -*- lexical-binding: t -*-
;;
;; Copyright (c) 2016-2018 ztlevi
;;
;; Author: ztlevi <zhouting@umich.edu>
;; URL: https://github.com/ztlevi/spacemacs-config
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst ztlevi-ui-packages
  '(
    all-the-icons
    all-the-icons-dired
    spaceline-all-the-icons
    popwin
    (whitespace :location built-in)
    (ivy-posframe :toggle (version<= "26" emacs-version))

    ;; company-box needs icons-in-terminal
    (icons-in-terminal :location local)
    (company-box :toggle (version<= "26" emacs-version))

    doom-themes
    ;; To use local repo, update the packages to clean up the cache
    ;; (doom-themes :location "~/Developer/Github/emacs-doom-themes")

    ;; doom modeline needs all-the-icons, shrink-path
    ;; (doom-modeline :location local)
    ;; shrink-path

    ;; (ztlevi-modeline :location local)
    )
  )

(defun ztlevi-ui/post-init-doom-themes ()
  (setq doom-themes-enable-bold t      ; if nil, bold is universally disabled
        doom-themes-enable-italic t)   ; if nil, italics is universally disabled
  ;; Enable flashing mode-line on errors
  ;; (doom-themes-visual-bell-config)

  ;; Enable custom neotree theme
  (doom-themes-neotree-config)          ; all-the-icons fonts must be installed!

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(defun ztlevi-ui/init-doom-modeline ()
  (use-package doom-modeline
    :init
    (use-package all-the-icons)

    ;; set doom-modeline height
    (setq +doom-modeline-height 32)

    ;; file-name style
    (setq +doom-modeline-buffer-file-name-style 'relative-to-project)

    (add-hook 'after-init-hook #'+doom-modeline|init)))

(defun ztlevi-ui/init-shrink-path ()
  (use-package shrink-path
    :defer t
    :commands (shrink-path-prompt shrink-path-file-mixed)))

(defun ztlevi-ui/init-all-the-icons-dired ()
  (use-package all-the-icons-dired
    :defer t
    :init
    (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)))

(defun ztlevi-ui/init-all-the-icons ()
  (use-package all-the-icons
    :defer t))

(defun ztlevi-ui/post-init-spaceline-all-the-icons ()
  (setq spaceline-all-the-icons-clock-always-visible nil)
  (setq spaceline-all-the-icons-flycheck-alternate t)
  (setq spaceline-all-the-icons-hide-long-buffer-path t)
  (setq spaceline-all-the-icons-highlight-file-name t)

  (setq spaceline-all-the-icons-icon-set-git-ahead (quote commit)))

(defun ztlevi-ui/init-ivy-posframe ()
  (use-package ivy-posframe
    :defer t
    :init
    (setq ivy-posframe-parameters
          '((left-fringe . 10)
            (right-fringe . 10)))

    ;; https://github.com/tumashu/ivy-posframe#how-to-enable-ivy-posframe
    ;; (setq ivy-display-function #'ivy-posframe-display)
    (setq ivy-display-function #'ivy-posframe-display-at-frame-center)

    (ivy-posframe-enable)))

(defun ztlevi-ui/init-icons-in-terminal ()
  (use-package icons-in-terminal
    :defer t))

(defun ztlevi-ui/init-company-box ()
  (use-package company-box
    :defer t
    :hook (company-mode . company-box-mode)
    :config
    (require 'icons-in-terminal)
    (progn
      (setq company-box-backends-colors nil)

      (setq company-box-icons-unknown 'fa_question_circle)

      (setq company-box-icons-elisp
            '((fa_tag :face font-lock-function-name-face) ;; Function
              (fa_cog :face font-lock-variable-name-face) ;; Variable
              (fa_cube :face font-lock-constant-face)     ;; Feature
              (md_color_lens :face font-lock-doc-face)))  ;; Face

      (setq company-box-icons-yasnippet 'fa_bookmark)

      (setq company-box-icons-lsp
            '((1 . fa_text_height)                               ;; Text
              (2 . (fa_tags :face font-lock-function-name-face)) ;; Method
              (3 . (fa_tag :face font-lock-function-name-face))  ;; Function
              (4 . (fa_tag :face font-lock-function-name-face))  ;; Constructor
              (5 . (fa_cog :foreground "#FF9800"))               ;; Field
              (6 . (fa_cog :foreground "#FF9800"))               ;; Variable
              (7 . (fa_cube :foreground "#7C4DFF"))              ;; Class
              (8 . (fa_cube :foreground "#7C4DFF"))              ;; Interface
              (9 . (fa_cube :foreground "#7C4DFF"))              ;; Module
              (10 . (fa_cog :foreground "#FF9800"))              ;; Property
              (11 . md_settings_system_daydream)                 ;; Unit
              (12 . (fa_cog :foreground "#FF9800"))              ;; Value
              (13 . (md_storage :face font-lock-type-face))      ;; Enum
              (14 . (md_closed_caption :foreground "#009688"))   ;; Keyword
              (15 . md_closed_caption)                           ;; Snippet
              (16 . (md_color_lens :face font-lock-doc-face))    ;; Color
              (17 . fa_file_text_o)                              ;; File
              (18 . md_refresh)                                  ;; Reference
              (19 . fa_folder_open)                              ;; Folder
              (20 . (md_closed_caption :foreground "#009688"))   ;; EnumMember
              (21 . (fa_square :face font-lock-constant-face))   ;; Constant
              (22 . (fa_cube :face font-lock-type-face))         ;; Struct
              (23 . fa_calendar)                                 ;; Event
              (24 . fa_square_o)                                 ;; Operator
              (25 . fa_arrows)) ;; TypeParameter
            ))))

(defun ztlevi-ui/post-init-pangu-spacing ()
  (progn
    ;; add toggle options
    (spacemacs|add-toggle toggle-pangu-spaceing
      :status pangu-spacing-mode
      :on (global-pangu-spacing-mode)
      :off (global-pangu-spacing-mode -1)
      :documentation "Toggle pangu spacing mode"
      :evil-leader "ots")
    (add-hook 'markdown-mode-hook
              #'(lambda ()
                  (set (make-local-variable 'pangu-spacing-real-insert-separtor) t)))))

(defun ztlevi-ui/post-init-popwin ()
  (progn
    (push "*ztlevi/run-current-file output*" popwin:special-display-config)
    (delete "*Async Shell Command*" popwin:special-display-config)))

(defun ztlevi-ui/post-init-whitespace ()
  (progn
    ;; ;; http://emacsredux.com/blog/2013/05/31/highlight-lines-that-exceed-a-certain-length-limit/
    (setq whitespace-line-column fill-column) ;; limit line length
    ;;https://www.reddit.com/r/emacs/comments/2keh6u/show_tabs_and_trailing_whitespaces_only/
    ;; (setq whitespace-style '(face lines-tail))
    ;; show tab;  use untabify to convert tab to whitespace
    (setq spacemacs-show-trailing-whitespace nil)

    (setq-default tab-width 4)
    ;; set-buffer-file-coding-system -> utf8 to convert dos to utf8
    ;; (setq inhibit-eol-conversion t)
    ;; (add-hook 'prog-mode-hook 'whitespace-mode)

    ;; (global-whitespace-mode +1)

    (with-eval-after-load 'whitespace
      (progn
        (set-face-attribute 'whitespace-trailing nil
                            :inherit font-lock-keyword-face
                            :underline t)
        (set-face-attribute 'whitespace-tab nil
                            :inherit font-lock-string-face
                            :underline t
                            :weight 'bold)))
    (diminish 'whitespace-mode)))

(defun ztlevi-ui/init-ztlevi-modeline ()
  (use-package ztlevi-modeline))
