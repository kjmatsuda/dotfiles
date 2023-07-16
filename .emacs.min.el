;; C-h でバックスペース
(keyboard-translate ?\C-h ?\C-?) ; C-h -> BS

;; これをすることで選択してから C-d で選択範囲を削除できる
(delete-selection-mode t)

;; バックアップファイルを作成しない
(setq make-backup-files nil)

;; オートセーブファイルを作らない
(setq auto-save-default nil)

;; load-pathをサブディレクトリごと追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name path)))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

(add-to-load-path "~/.emacs.min.d")

;; undo
(require 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "C-M-/") 'undo-tree-redo)
;; undo-tree 0.8 から履歴ファイル(*.~undo-tree~)を自動的に作成するようになっているので、それを無効化する
(setq undo-tree-auto-save-history nil)

;; welcomeページを表示させない
(setq inhibit-startup-message t)


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
