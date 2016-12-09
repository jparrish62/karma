class Appointment < ApplicationRecord
  belongs_to :user,    optional: true
  belongs_to :stylist, optional: true


end
