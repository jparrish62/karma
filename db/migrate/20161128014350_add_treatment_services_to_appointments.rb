class AddTreatmentServicesToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :treatment_services, :string
  end
end
