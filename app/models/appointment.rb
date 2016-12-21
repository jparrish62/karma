class Appointment < ApplicationRecord
  validates  :name,                  presence: true
  validates  :appointment_date_time, presence: true
  belongs_to :user,                  optional: true
  belongs_to :stylist,               optional: true

  def self.scheduled?(appointment)
    Appointment.where("appointments.appointment_date_time == ?", appointment.appointment_date_time).any?
  end
end
