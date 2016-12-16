class AppointmentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @stylist = Stylist.find(params[:stylist_id])
    @stylist.email = @stylist.email.downcase!
    @appointment = @stylist.appointments.build(app_params)
    @appointment.user = current_user
    if @appointment.save!
      AppointmentMailer.email_stylist(@stylist)
      session[:appointment_id] = @appointment.id
      google_appointment = GoogleCalendarAppointment.new(@appointment, @stylist)
      google_client = google_appointment.initial_call(oauth2callback_url)
      redirect_to google_client.authorization_uri.to_s, notice: "Appointmnet Created"
    else
      redirect_to stylist_path(@stylist),notice: "Could Not Create Appointmnet"
    end
  end

  private

  def app_params
    params.require(:appointment).permit(:name, :start_time, :time, :basic_services,
                   :chemical_services, :color_services,:treatment_services, :weave,
                   :braid, :comment)
  end
end
