class AddAppointmentDateTimeToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :appointment_date_time, :datetime
  end
end
