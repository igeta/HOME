;; init.el -*- mode: emacs-lisp; coding: utf-8 -*-
;;
;; for GNU Emacs 24.x on Windows (ja-JP)
;;

;; バックアップ ファイルを一箇所にまとめる
(setq backup-directory-alist '(("." . "~/.emacs.d/backup")))
;; 警告音・画面点滅を無効化
(setq visible-bell t)
(setq ring-bell-function 'ignore)
;; メニューバーとツールバーの非表示
(menu-bar-mode 0)
(tool-bar-mode 0)
;; スタートアップの非表示
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
;; モードラインに行番号・列番号を表示
(line-number-mode t)
(column-number-mode t)
;; 各行の左側に行番号を表示
(global-linum-mode t)
(setq linum-format "%5d")
;; C-h でバックスペース
(keyboard-translate ?\C-h ?\C-?)
;(global-set-key nil)
;; 行頭でのキルは改行を含める
(setq kill-whole-line t)
;; 暫定マーク モードをオフ
(transient-mark-mode 0)
;; タブ文字：幅4、インデントはスペースで
(custom-set-variables '(tab-width 4))
(setq-default indent-tabs-mode nil)
;; 行間
;(setq-default line-spacing 0)
;; スクロール：1行ごと、余白なし、画面スクロール時1行残し
(setq scroll-conservatively 1)
(setq scroll-margin 0)
(setq next-screen-context-lines 1)
;; 対応する括弧の強調表示
(show-paren-mode t)
(setq show-paren-delay 0)
;; バッファ 切り換え時の補完
(iswitchb-mode t)
;(iswitchb-default-keybindings)
;; 多国語
(if (featurep 'mule)
    (progn ;; 言語
           (set-language-environment 'Japanese)
           ;; 文字コード
           (set-default-coding-systems     'cp932-dos)
           (setq file-name-coding-system   'cp932-dos)
           (prefer-coding-system           'utf-8-dos)
           (set-buffer-file-coding-system  'utf-8-dos)
           (if (not window-system) (set-terminal-coding-system 'cp932-dos))
           (setq process-coding-system-alist
                 (cons '("cmdproxy.exe$" cp932-dos . cp932-dos)
                       process-coding-system-alist))
           ;; DDSKK load-path の設定
           ;(setq load-path (cons "~/Apps/emacs-24.2/site-lisp/skk" load-path))
           ;; DDSKK info ディレクトリの設定
           ;(setq Info-default-directory-list
           ;      (cons "~/Apps/emacs-24.2/info" Info-default-directory-list))
           ))
;; 行末の空白を強調表示
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace nil)
(set-face-underline 'trailing-whitespace "SteelBlue")
;; 全角空白・タブ文字の強調表示
(defface face-zenspc '((t (:background "LightGray"))) nil)
(defface face-tab    '((t (:background "gray32"))) nil)
(defvar face-zenspc 'face-zenspc)
(defvar face-tab    'face-tab)
(defadvice font-lock-mode
           (before fine-font-lock-mode ())
           (font-lock-add-keywords major-mode
                                   '(("　"    0 face-zenspc append)
                                     ("\t"    0 face-tab    append)
                                    )))
(ad-enable-advice 'font-lock-mode 'before 'fine-font-lock-mode)
(ad-activate 'font-lock-mode)
(add-hook 'find-file-hooks
          '(lambda () (if font-lock-mode nil (font-lock-mode t))) t)
;; GUI
(if window-system
    (progn ;; フォント
           (set-face-attribute 'default nil
                               :family "Consolas"
                               :height 110)
           (set-fontset-font   "fontset-default"
                               'japanese-jisx0208
                               (font-spec :family "MeiryoKe_Console"))
           ;; 基本カラー
           (set-face-attribute 'default nil
                               :foreground "LightGray"
                               :background "Black")
           (set-face-attribute 'fringe nil
                               :background "Gray12")
           (set-face-attribute 'linum nil
                               :foreground "Gray64")
           (set-frame-parameter nil 'alpha '(90 nil))
           ;; フレーム位置
           (setq initial-frame-alist
                 (append '((top    . 46)
                           (left   . 60)
                           (width  . 120)
                           (height . 38))
                         initial-frame-alist))
           (setq default-frame-alist initial-frame-alist)
           ))

