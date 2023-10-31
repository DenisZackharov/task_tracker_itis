class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :content

      t.timestamps
    end

    add_reference :comments, :user, null: false, foreign_key: true
    add_reference :comments, :task, null: false, foreign_key: true
  end
end
