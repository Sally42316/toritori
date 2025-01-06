class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.references :user, null: false # 外部キー制約を持つ user_id（users テーブル）
      t.string :title, null: false # 投稿のタイトル
      t.text :text, null: false # 投稿の内容
      t.string :status, null: false, default: 'active' # 投稿のステータス（ENUM 型として扱う）
      t.index :status # ステータスにインデックスを追加

      t.timestamps
    end
  end
end
