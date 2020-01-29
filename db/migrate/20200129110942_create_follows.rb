class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.integer :is_follow
      t.string :follow_id
      t.string :integer
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
