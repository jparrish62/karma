class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.string :name
      t.string :date
      t.string :time
      t.text :comment
      t.string :basic_services
      t.string :chemical_services
      t.string :color_services
      t.string :weave
      t.string :braid
      t.datetime :start_time
      t.references :user, foreign_key: true
      t.references :stylist, foreign_key: true

      t.timestamps
    end
  end
end
