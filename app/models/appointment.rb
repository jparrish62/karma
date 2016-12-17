class Appointment < ApplicationRecord
  validates  :name,    presence: true
  belongs_to :user,    optional: true
  belongs_to :stylist, optional: true

  def self.scheduled(appointment)
    Appointment.where("date == ?", "%#{appointment.date}%") && Appointment.where("time == ?", "%#{appointment.time}%")
  end
end
