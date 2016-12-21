require 'rails_helper'

feature 'Create an appointment', :appointment do
  scenario 'User can create an appointment' do
    appointment = FactoryGirl.create(:appointment)
    expect(appointment).to be_valid
  end

  scenario 'User will be notified if an appointment exist at corresponding time' do
    new_appointment_time      = FactoryGirl.create(:appointment,  time:"12:00")
    existing_appointment_time = FactoryGirl.create(:appointment, time:"12:00")
    expect(Appointment.scheduled(new_appointment_time )).to eq true
  end
end
