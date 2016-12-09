class AddUserIdToStylists < ActiveRecord::Migration[5.0]
  def change
    add_reference :stylists, :user, foreign_key: true
  end
end
