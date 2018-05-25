;;; keybindings.el --- ztlevi-ui layer packages file for Spacemacs. -*- lexical-binding: t -*-
;;
;; Copyright (c) 2016-2018 ztlevi
;;
;; Author: ztlevi <zhouting@umich.edu>
;; URL: https://github.com/ztlevi/spacemacs-config
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; window split and focus
(spacemacs/set-leader-keys "wv" 'split-window-right-and-focus)
(spacemacs/set-leader-keys "ws" 'split-window-below-and-focus)
(define-key evil-normal-state-map (kbd "C-w v") 'split-window-right-and-focus)
(define-key evil-normal-state-map (kbd "C-w s") 'split-window-below-and-focus)
(define-key evil-visual-state-map (kbd "C-w v") 'split-window-right-and-focus)
(define-key evil-visual-state-map (kbd "C-w s") 'split-window-below-and-focus)
(define-key evil-normal-state-map (kbd "<RET>") 'ivy-switch-buffer)
(define-key evil-visual-state-map (kbd "<RET>") 'ivy-switch-buffer)

;; evil hybrid
(define-key evil-hybrid-state-map (kbd "C-r") 'evil-paste-from-register)
(define-key evil-hybrid-state-map (kbd "C-z") 'evil-emacs-state)

;; ex completion
(define-key evil-ex-completion-map (kbd "C-d") 'delete-forward-char)

;; use black hole register
(define-key evil-visual-state-map (kbd "<del>") (kbd "\"_d"))
(define-key evil-visual-state-map (kbd "<backspace>") (kbd "\"_d"))

;; evil inc-num, dec-num, find-char-reverse, insert space before and after
(define-key evil-normal-state-map (kbd "-") nil)
(bb/define-key evil-normal-state-map
  "+" 'evil-numbers/inc-at-pt
  "-" 'evil-numbers/dec-at-pt
  "\\" 'evil-repeat-find-char-reverse
  (kbd "DEL") 'evil-repeat-find-char-reverse
  "[s" (lambda (n) (interactive "p") (dotimes (c n nil) (insert " ")))
  "]s" (lambda (n) (interactive "p")
         (forward-char) (dotimes (c n nil) (insert " ")) (backward-char (1+ n))))

;; counsel etags
(define-key evil-normal-state-map (kbd "gF") 'counsel-etags-find-tag-at-point)
(define-key evil-normal-state-map (kbd "gb") 'pop-tag-mark)
(define-key evil-normal-state-map (kbd "gR") 'counsel-etags-recent-tag)
(spacemacs/set-leader-keys "ou" 'counsel-etags-update-tags-force)

;; stack exchange
(define-prefix-command 'launcher-map)
(global-set-key (kbd "s-l") 'launcher-map)
(define-key launcher-map "q" #'sx-tab-all-questions)
(define-key launcher-map "i" #'sx-inbox)
(define-key launcher-map "o" #'sx-open-link)
(define-key launcher-map "u" #'sx-tab-unanswered-my-tags)
(define-key launcher-map "a" #'sx-ask)
(define-key launcher-map "s" #'sx-search)

;; imenu list
(spacemacs/set-leader-keys "bi" #'imenu-list-smart-toggle)

;; company complete
(global-set-key (kbd "C-SPC") 'company-complete)

;; comment
(global-set-key (kbd "s-/") 'spacemacs/comment-or-uncomment-lines)

;; macro
(global-set-key (kbd "s-m") 'call-last-kbd-macro)
(spacemacs/set-leader-keys "om" 'kmacro-edit-macro)

;; expand region
(global-set-key (kbd "C-s-.") 'er/expand-region)
(global-set-key (kbd "C-s-,") 'er/contract-region)

;; prettier js
(spacemacs/set-leader-keys "tp" 'prettier-js-mode)

;; redefine C-i and S-tab
(global-set-key (kbd "<C-i>") 'evil-shift-right-line)
(global-set-key (kbd "<S-tab>") 'evil-shift-left-line)

;; helm bookmark keybindings
(spacemacs/set-leader-keys (kbd "fb") 'helm-filtered-bookmarks)
(with-eval-after-load 'helm-bookmark
  (progn
    (bb/define-key helm-bookmark-map (kbd "C-o") 'helm-bookmark-run-jump-other-window)
    (bb/define-key helm-bookmark-map (kbd "C-d") 'helm-bookmark-run-delete)
    (bb/define-key helm-bookmark-map (kbd "C-f") 'helm-bookmark-toggle-filename)
    (bb/define-key helm-bookmark-map (kbd "C-e") 'helm-bookmark-run-edit)))

;; yasnippet
(define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand)
(spacemacs/set-leader-keys "yr" 'yas-reload-all)
(spacemacs/set-leader-keys "yd" 'yas-describe-tables)

;; fix yasnippet with unbinding emmet keys
(eval-after-load 'emmet-mode
  '(progn
     (evil-define-key 'insert emmet-mode-keymap (kbd "TAB") nil)
     (evil-define-key 'insert emmet-mode-keymap (kbd "<tab>") nil)
     (evil-define-key 'emacs emmet-mode-keymap (kbd "TAB") nil)
     (evil-define-key 'emacs emmet-mode-keymap (kbd "<tab>") nil)
     (evil-define-key 'hybrid emmet-mode-keymap (kbd "TAB") nil)
     (evil-define-key 'hybrid emmet-mode-keymap (kbd "<tab>") nil)))

;; buffer key
(spacemacs/set-leader-keys "bf" 'ztlevi/open-finder-in-current-dir)
(spacemacs/set-leader-keys "bt" 'ztlevi/open-terminal-in-current-dir)
(spacemacs/set-leader-keys "bT" 'ztlevi/open-markdown-in-typora)

;; importmagic
(spacemacs/set-leader-keys-for-major-mode 'python-mode
  "i" 'importmagic-fix-symbol-at-point)

;; mark all
(spacemacs/set-leader-keys "aa" 'mark-whole-buffer)

;; ein jupyter
(spacemacs/set-leader-keys "ays" 'ein:jupyter-server-start)
(spacemacs/set-leader-keys-for-major-mode 'ein:notebook-multilang-mode "c" 'ein:worksheet-change-cell-type)
(spacemacs/set-leader-keys-for-major-mode 'ein:notebook-multilang-mode "a" 'ein:worksheet-execute-all-cell)

;; neotree
(with-eval-after-load 'neotree
  (define-key neotree-mode-map (kbd "f") 'counsel-find-file)
  (define-key neotree-mode-map (kbd "+") 'make-directory))
;; treemacs
(with-eval-after-load 'treemacs
  (define-key treemacs-mode-map (kbd "ov") 'treemacs-visit-node-horizontal-split)
  (define-key treemacs-mode-map (kbd "os") 'treemacs-visit-node-vertical-split)
  (define-key evil-treemacs-state-map (kbd "f") 'counsel-find-file)
  (define-key evil-treemacs-state-map (kbd "+") 'make-directory))

;; remap C-h with delte, C-M-h with help-command
;; (define-key evil-hybrid-state-map (kbd "C-h") 'delete-backward-char)
;; (global-set-key (kbd "C-M-h") 'help-command)
(global-set-key (kbd "C-h h") nil)

;; A complementary binding to the apropos-command (C-h a)
(define-key 'help-command "A" 'apropos)
(define-key 'help-command (kbd "C-f") 'find-function)
(define-key 'help-command (kbd "C-k") 'find-function-on-key)
(define-key 'help-command (kbd "C-v") 'find-variable)
(define-key 'help-command (kbd "C-l") 'find-library)
(define-key 'help-command (kbd "C-i") 'info-display-manual)

(global-set-key [(shift return)] 'ztlevi/smart-open-line)
(global-set-key (kbd "C-c a") 'org-agenda)
(define-key global-map (kbd "C-c y") 'youdao-dictionary-search-at-point+)
(define-key global-map (kbd "<f9>") 'org-capture)
(define-key global-map (kbd "C-c t") 'org-capture)
(define-key global-map (kbd "<f8>") 'ztlevi/show-current-buffer-major-mode)

(global-set-key (kbd "C-c b") 'org-iswitchb)
(global-set-key (kbd "C-c i e") 'spacemacs/auto-yasnippet-expand)

(global-set-key [remap fill-paragraph] #'endless/fill-or-unfill)

(global-set-key (kbd "s-g") 'goto-line)
(global-set-key (kbd "C-`") 'toggle-input-method)
(bind-key* "s-r" 'mc/reverse-regions)
(global-set-key (kbd "<f5>") 'ztlevi/run-current-file)

;; "http://endlessparentheses.com/transposing-keybinds-in-emacs.html?source=rss"
;; (global-set-key "\C-t" #'transpose-lines)
;; (define-key ctl-x-map "\C-t" #'transpose-chars)

(spacemacs|add-toggle toggle-shadowsocks-proxy-mode
  :status shadowsocks-proxy-mode
  :on (global-shadowsocks-proxy-mode)
  :off (global-shadowsocks-proxy-mode -1)
  :documentation "Toggle shadowsocks proxy mode."
  :evil-leader "ots")

;; (bind-key* "s-k" 'scroll-other-window-down)
;; (bind-key* "s-j"  'scroll-other-window)
(bind-key* "C-c /" 'company-files)
;; (bind-key* "s-r" 'ztlevi/browser-refresh--chrome-applescript)
(bind-key* "s-;" 'ztlevi/insert-semicolon-at-the-end-of-this-line)
(bind-key* "C-s-;" 'ztlevi/delete-semicolon-at-the-end-of-this-line)
(bind-key* "s-," 'ztlevi/insert-comma-at-the-end-of-this-line)
;; (bind-key* "C-s-," 'ztlevi/delete-comma-at-the-end-of-this-line)
(bind-key* "C-c l" 'ztlevi/insert-chrome-current-tab-url)
;; (bind-key* "M-s o" 'occur-dwim)
(bind-key* "M--" 'ztlevi/goto-match-paren)
(bind-key* "C-c k" 'which-key-show-top-level)
(bind-key* "s-y" 'aya-expand)
;; (bind-key* "C-l" 'recenter)

;; (spacemacs/set-leader-keys "op" 'ztlevi/org-save-and-export)
(spacemacs/set-leader-keys "fR" 'ztlevi/rename-file-and-buffer)

;;Must set key to nil to prevent error: Key sequence b m s starts with non-prefix key b m
(spacemacs/set-leader-keys "bD" 'spacemacs/kill-other-buffers)
(spacemacs/declare-prefix "B" "bookmark")
(spacemacs/set-leader-keys "Bs" 'bookmark-set)
(spacemacs/set-leader-keys "Br" 'bookmark-rename)
(spacemacs/set-leader-keys "Bd" 'bookmark-delete)
(spacemacs/set-leader-keys "Bj" 'counsel-bookmark)
(spacemacs/set-leader-keys "Bb" 'bookmark-bmenu-list)

;; custom key
(global-set-key (kbd "<f1>") 'ztlevi/helm-hotspots)
(spacemacs/declare-prefix "ot" "Toggle")
(spacemacs/set-leader-keys "otf" 'focus-mode)
(spacemacs/set-leader-keys "oo" 'ztlevi/helm-hotspots)
(spacemacs/set-leader-keys "oy" 'youdao-dictionary-search-at-point+)
(spacemacs/set-leader-keys "ok" 'helm-show-kill-ring)
(spacemacs/set-leader-keys "o(" 'ielm)
(spacemacs/set-leader-keys "og" 'my-git-timemachine)
(spacemacs/set-leader-keys "oc" 'eacl-complete-tag)
(spacemacs/set-leader-keys "od" 'occur-dwim)
(spacemacs/set-leader-keys "on" 'occur-non-ascii)
(spacemacs/set-leader-keys "ox" 'org-open-at-point-global)
(spacemacs/set-leader-keys "or" 'revert-buffer-no-confirm)
(spacemacs/set-leader-keys "oR" 'ztlevi/browser-refresh--chrome-applescript)
(spacemacs/set-leader-keys "oT" 'ztlevi/untabify-buffer)
(spacemacs/set-leader-keys "op" 'prettier-js)
(spacemacs/set-leader-keys (kbd "of") 'counsel-git)

(spacemacs/set-leader-keys "rr" 'rjsx-mode)

;; resume
(spacemacs/set-leader-keys "rh" 'helm-resume)
(spacemacs/set-leader-keys "ri" 'ivy-resume)
(spacemacs/set-leader-keys "rb" 'popwin:display-last-buffer)

;; flycheck
(spacemacs/set-leader-keys "en" 'flycheck-next-error)
(spacemacs/set-leader-keys "ep" 'flycheck-previous-error)

(spacemacs/set-leader-keys "gL" 'magit-log-buffer-file)

;; dash find
(spacemacs/set-leader-keys "fd" 'dash-at-point)
(spacemacs/set-leader-keys "fD" 'dash-at-point-with-docset)

;; deal with BOM
(spacemacs/set-leader-keys "fl" 'find-file-literally-at-point)
(spacemacs/set-leader-keys "fh" 'ffap-hexl-mode)

;; layout
(spacemacs/declare-prefix "ol" "layout")
(spacemacs/set-leader-keys "oll" 'ztlevi/load-my-layout)
(spacemacs/set-leader-keys "ols" 'ztlevi/save-my-layout)

;; keybindings for linux and macOS
(when (or (spacemacs/system-is-linux) (spacemacs/system-is-mac))
  (global-set-key (kbd "s-p") 'counsel-git)
  (global-set-key (kbd "s-s") 'evil-write-all)
  (global-set-key (kbd "s-w") 'delete-window-or-frame)
  (global-set-key (kbd "C-S-o") 'other-frame)
  (global-set-key (kbd "s-=") 'spacemacs/scale-up-font)
  (global-set-key (kbd "s--") 'spacemacs/scale-down-font)
  (global-set-key (kbd "s-0") 'spacemacs/reset-font-size)
  (global-set-key (kbd "s-q") 'save-buffers-kill-terminal)
  (global-set-key (kbd "s-v") 'yank)
  (global-set-key (kbd "s-c") 'evil-yank)
  (global-set-key (kbd "s-a") 'mark-whole-buffer)
  (global-set-key (kbd "s-x") 'kill-region)
  (global-set-key (kbd "s-n") 'make-frame)
  (global-set-key (kbd "s-z") 'undo-tree-undo)
  (global-set-key (kbd "s-Z") 'undo-tree-redo)
  ;; hungry delete
  (global-set-key (kbd "s-<backspace>") 'hungry-delete-backward)
  ;; iterm
  (spacemacs/set-leader-keys "o!" 'ztlevi/iterm-shell-command))
;; keybindings for Windows
(when (spacemacs/system-is-mswindows)
  (global-set-key (kbd "C-S-p") 'counsel-git)
  (global-set-key (kbd "C-S-s") 'evil-write-all)
  (global-set-key (kbd "C-S-w") 'delete-window-or-frame)
  (global-set-key (kbd "C-S-o") 'other-frame)
  (global-set-key (kbd "C-=") 'spacemacs/scale-up-font)
  (global-set-key (kbd "C--") 'spacemacs/scale-down-font)
  (global-set-key (kbd "C-0") 'spacemacs/reset-font-size)
  (global-set-key (kbd "C-S-q") 'save-buffers-kill-terminal)
  (global-set-key (kbd "C-v") 'yank)
  (global-set-key (kbd "C-S-v") 'yank)
  (global-set-key (kbd "C-S-c") 'evil-yank)
  (global-set-key (kbd "C-S-a") 'mark-whole-buffer)
  (global-set-key (kbd "C-S-x") 'kill-region)
  (global-set-key (kbd "C-S-n") 'make-frame)
  (global-set-key (kbd "C-S-z") 'undo-tree-undo)
  ;; hungry delete
  (global-set-key (kbd "C-<backspace>") 'hungry-delete-backward))
