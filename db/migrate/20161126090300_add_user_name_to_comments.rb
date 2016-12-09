class AddUserNameToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :user_name, :string
    add_reference :comments, :works, foreign_key: true
  end
end
