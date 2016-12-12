class AppointmentMailer < ApplicationMailer
  default from: 'karmasalon@gmail.com'

  def email_stylist(stylist)
    mail(to: stylist.email.downcase, subject: 'New appointment')
  end
end
