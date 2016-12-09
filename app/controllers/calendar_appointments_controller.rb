class CalendarAppointmentsController < ApplicationController
  # GET /response callback from GOOGLE
  def callback
    client = GoogleCalendarAppointment.new(:nil)
    google_client = client.callback_obj(params, url_for(:action => :callback))
    response = google_client.fetch_access_token!
    session[:access_token] = response['access_token']
    redirect_to url_for(:action => :calendars)
  end

  def calendars
    appointment = Appointment.find(session[:appointment_id])
    appointment_obj = GoogleCalendarAppointment.new(appointment)
    appointment_obj.calendars(session[:access_token])
    redirect_to stylist_path(appointment.stylist),notice: "Appointment Succesfully Created"
  end
end
