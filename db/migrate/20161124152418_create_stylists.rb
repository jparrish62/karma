class CreateStylists < ActiveRecord::Migration[5.0]
  def change
    create_table :stylists do |t|
      t.string :name
      t.string :email
      t.text :bio

      t.timestamps
    end
  end
end
