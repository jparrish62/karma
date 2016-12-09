class AppointmentMailer < ApplicationMailer
  default from: 'karmasalon@gmail.com'

  def email_stylist(stylist)
    mail(to: stylist.email, subject: 'New appointment')
  end
end
