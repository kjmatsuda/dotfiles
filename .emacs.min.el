;; C-h でバックスペース
(keyboard-translate ?\C-h ?\C-?) ; C-h -> BS

;; これをすることで選択してから C-d で選択範囲を削除できる
(delete-selection-mode t)

;; バックアップファイルを作成しない
(setq make-backup-files nil)

;; オートセーブファイルを作らない
(setq auto-save-default nil)

(if (not (file-directory-p "~/.emacs.min.d/"))
    (make-directory "~/.emacs.min.d/"))

(setq user-emacs-directory "~/.emacs.min.d/")

;; load-pathをサブディレクトリごと追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name path)))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

(add-to-load-path "~/.emacs.min.d/straight/build/")

;; straight.el自身のインストールと初期設定を行ってくれる
(let ((bootstrap-file (concat user-emacs-directory "straight/repos/straight.el/bootstrap.el"))
      (bootstrap-version 3))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; オプションなしで自動的にuse-packageをstraight.elにフォールバックする
;; 本来は (use-package hoge :straight t) のように書く必要がある
;; (setq straight-use-package-by-default t)
;; use-packageをインストールする
(straight-use-package 'use-package)


;; OSのタイプを格納
(defvar os-type nil)

(cond ((string-match "apple-darwin" system-configuration) ;; Mac
       (setq os-type 'mac))
      ((string-match "linux" system-configuration)        ;; Linux
       (setq os-type 'linux))
      ((string-match "freebsd" system-configuration)      ;; FreeBSD
       (setq os-type 'bsd))
      ((string-match "mingw" system-configuration)        ;; Windows
       (setq os-type 'win)))

;; OSのタイプを判別する
(defun mac? ()
  (eq os-type 'mac))

(defun linux? ()
  (eq os-type 'linux))

(defun bsd? ()
  (eq os-type 'freebsd))

(defun win? ()
  (eq os-type 'win))

;; Termuxか否かを判別する
(defvar which-bash-str "")
(setq which-bash-str (shell-command-to-string "which bash"))

(defun is-termux()
  (if (string-match "termux" which-bash-str)
      t
    nil))

;; undo
(use-package undo-tree
  :straight t
  :config
  (global-undo-tree-mode t)
  (if (not (is-termux))
      (global-set-key (kbd "C-M-/") 'undo-tree-redo)
    (global-set-key (kbd "M-/") 'undo-tree-redo)
    )
  ;; undo-tree 0.8 から履歴ファイル(*.~undo-tree~)を自動的に作成するようになっているので、それを無効化する
  (setq undo-tree-auto-save-history nil)
  )

;====================================
; Initial フレームサイズ,位置,色,フォントなど
;====================================
(setq initial-frame-alist
(append (list
'(width . 100) ;; ウィンドウ幅
'(height . 55) ;; ウィンドウ高さ
'(top . 30) ;; 表示位置
'(left . 100) ;; 表示位置
)
initial-frame-alist))
(setq default-frame-alist initial-frame-alist)
