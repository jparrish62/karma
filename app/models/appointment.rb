class Appointment < ApplicationRecord
  validates  :name,    presence: true
  belongs_to :user,    optional: true
  belongs_to :stylist, optional: true

  def self.scheduled(params)
    Appointment.where("time == ?", "%#{params[:time]}%") && Appointment.where("date == ?", "%#{params[:date]}%") 
  end
end
