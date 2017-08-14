;;; doom-one-light-theme.el --- inspired by Atom One Light
(require 'doom-themes)

;;
(defgroup doom-one-light-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-one-light-with-solaire-mode-enabled t
  "Default t. If you do not use solaire-mode, set it to nil"
  :group 'doom-one-light-theme
  :type 'boolean)

(defcustom doom-one-light-darker-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-one-light-theme
  :type 'boolean)

(defcustom doom-one-light-darker-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-one-light-theme
  :type 'boolean)

(defcustom doom-one-light-comment-bg doom-one-light-darker-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-one-light-theme
  :type 'boolean)

(defcustom doom-one-light-padded-modeline nil
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-one-light-theme
  :type '(or integer boolean))

;;
(def-doom-theme doom-one-light
  "A dark theme inspired by Atom One"

  ;; name        default   256       16
  ((bg         '("#fafafa" nil       nil            ))
   (bg-alt     '("#f0f0f0" nil       nil            ))
   (base0      '("#f0f0f0" "#f0f0f0" "white"        ))
   (base1      '("#e7e7e7" "#e7e7e7" "brightblack"  ))
   (base2      '("#dfdfdf" "#dfdfdf" "brightblack"  ))
   (base3      '("#c6c7c7" "#c6c7c7" "brightblack"  ))
   (base4      '("#9ca0a4" "#9ca0a4" "brightblack"  ))
   (base5      '("#383a42" "#424242" "brightblack"  ))
   (base6      '("#202328" "#2e2e2e" "brightblack"  ))
   (base7      '("#1c1f24" "#1e1e1e" "brightblack"  ))
   (base8      '("#1b2229" "black"   "black"        ))
   (fg         '("#383a42" "#424242" "black"        ))
   (fg-alt     '("#c6c7c7" "#c7c7c7" "brightblack"  ))

   (grey       base4)
   (red        '("#e45649" "#e45649" "red"          ))
   (orange     '("#da8548" "#dd8844" "brightred"    ))
   (green      '("#50a14f" "#50a14f" "green"        ))
   (teal       '("#4db5bd" "#44b9b1" "brightgreen"  ))
   (yellow     '("#986801" "#986801" "yellow"       ))
   (blue       '("#4078f2" "#4078f2" "brightblue"   ))
   (dark-blue  '("#a0bcf8" "#a0bcf8" "blue"         ))
   (magenta    '("#a626a4" "#a626a4" "magenta"      ))
   (violet     '("#b751b6" "#b751b6" "brightmagenta"))
   (cyan       '("#0184bc" "#0184bc" "brightcyan"   ))
   (dark-cyan  '("#005478" "#005478" "cyan"         ))

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   base2)
   (selection      dark-blue)
   (builtin        magenta)
   (comments       (if doom-one-light-darker-comments dark-cyan base4))
   (doc-comments   (doom-darken (if doom-one-light-darker-comments dark-cyan base5) 0.25))
   (constants      violet)
   (functions      magenta)
   (keywords       red)
   (methods        cyan)
   (operators      blue)
   (type           yellow)
   (strings        green)
   (variables      (doom-darken magenta 0.36))
   (numbers        orange)
   (region         `(,(doom-darken (car bg-alt) 0.1) ,@(doom-darken (cdr base0) 0.3)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    base4)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (-modeline-darker doom-one-light-darker-modeline)
   (-modeline-pad
    (when doom-one-light-padded-modeline
      (if (integerp doom-one-light-padded-modeline) doom-one-light-padded-modeline 4)))

   (modeline-fg     nil)
   (modeline-fg-alt (doom-blend violet base4 (if -modeline-darker 0.5 0.2)))

   (modeline-bg
    (if doom-one-light-with-solaire-mode-enabled
        (if -modeline-darker
            (doom-darken base4 0.475)
          `(,(car bg) ,@(cdr base0)))
      (if -modeline-darker
          (doom-darken base1 0.15)
          base1)))
   (modeline-bg-d
    (if doom-one-light-with-solaire-mode-enabled
        (if -modeline-darker
            (doom-darken base4 0.45)
          `(,(doom-darken (car bg-alt) 0.125) ,@(cdr base0)))
      (if -modeline-darker
          (doom-darken base2 0.15)
        base2)))
   (modeline-bg-inactive   (doom-darken bg 0.1))
   (modeline-bg-inactive-d `(,(car bg-alt) ,@(cdr base1))))

  ;; --- extra faces ------------------------
  ((font-lock-comment-face
    :foreground comments
    :background (if doom-one-light-comment-bg (doom-darken bg-alt 0.095)))
   (font-lock-doc-face
    :inherit 'font-lock-comment-face
    :foreground doc-comments)

   (line-number :inherit 'default :foreground (doom-lighten base4 0.15) :distant-foreground nil :bold nil)
   (line-number-current-line :inherit 'hl-line :foreground base8 :distant-foreground nil :bold nil)
   (hl-line :background (if doom-one-light-with-solaire-mode-enabled base2 base1))
   (solaire-hl-line-face :inherit 'hl-line :background base2)

   (doom-modeline-bar :background (if -modeline-darker modeline-bg highlight))

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis
    :foreground (if -modeline-darker base8 highlight))

   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-d
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-d)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-d
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-d)))

   ;; magit
   (magit-blame-heading     :foreground orange :background bg-alt)
   (magit-diff-removed :foreground (doom-darken red 0.2) :background (doom-blend red bg 0.1))
   (magit-diff-removed-highlight :foreground red :background (doom-blend red bg 0.2) :bold bold)

   ;; --- major-mode faces -------------------
   ;; css-mode / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)

   ;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   (markdown-code-face :background (doom-darken base3 0.05))

   ;; org-mode
   (org-block            :background bg)
   (org-block-begin-line :foreground fg :slant 'italic)
   (org-level-1          :background bg :foreground red :bold t :height 1.2)
   (org-level-3          :bold 'bold :foreground violet :height 1.1)
   (org-ellipsis         :underline nil :background bg :foreground red)
   )

  ;; --- extra variables ---------------------
  ;; ()
  )

;;; doom-one-light-theme.el ends here
