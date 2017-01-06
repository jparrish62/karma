class AppointmentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @stylist = Stylist.find(params[:stylist_id])
    @stylist.email = @stylist.email.downcase!
    @appointment = @stylist.appointments.build(app_params)
    @appointment.user = current_user
    if Appointment.scheduled?(@appointment)
      redirect_to :back, notice: "Appointment Taken. Please adjust time by 15min"
    elsif @appointment.save
      AppointmentMailer.email_stylist(@stylist)
      google_appointment = GoogleCalendarAppointment.new(@appointment).create_calendar_event
      redirect_to stylist_path(@stylist),notice: "Your appointment was created."
    else
      redirect_to stylist_path(@stylist),notice: "Sorry Appointmnet Couldn't Be Created. Make sure Name, Date and Time fields are filled out"
    end
  end

  private

  def app_params
    params.require(:appointment).permit(:name, :appointment_date_time, :basic_services,
                   :chemical_services, :color_services,:treatment_services, :weave,
                   :braid, :comment)
  end
end
