class GoogleCalendarAppointment
  attr_accessor :appointment

  def initialize(appointment)
    @appointment = appointment
  end

  def authorized_client
    @authorized_client ||= Signet::OAuth2::Client.new(
       :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
       :audience             => 'https://accounts.google.com/o/oauth2/token',
       :scope                => 'https://www.googleapis.com/auth/calendar',
       :issuer               => ENV["GSA_CLIENT_EMAIL"],
       :person               => ENV["SALON_GMAIL_ACCOUNT"],
       :signing_key          => OpenSSL::PKey::RSA.new(ENV["GSA_PRIVATE_KEY"].gsub("\\n", "\n"), 'notasecret'))
    @authorized_client.fetch_access_token!
    @authorized_client
  end

  def create_calendar_event
    authorized_client.expires_in = Time.now + 1_000_000
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = authorized_client
    service.insert_event("primary", client_appointment)
  end

  def client_appointment
    Google::Apis::CalendarV3::Event.new({
      summary: "New Appointment for #{appointment.stylist.name} Client:#{appointment.name}",
      location: 'Karma Salon',
      description: "Treatment Services #{apt.treatment_services || 'Not requested'}, Chemical Services #{apt.chemical_services || 'Not requested'},Color services #{apt.color_services || 'Non requested'}, Braid #{apt.braid || 'Not requested'}, Basic services #{apt.basic_services || 'Not requested'}, Weave #{apt.weave || 'Not requested'}",
      start: {
        date_time: "#{appointment.appointment_date_time.strftime('%Y-%m-%dT%H:%M:%S')}",
        time_zone: 'America/New_York',
      },
      end: {
        date_time: "#{(appointment.appointment_date_time + 1.hour).strftime('%Y-%m-%dT%H:%M:%S')}",
        time_zone: 'America/New_York',
      }
    })
  end

  def app_date_time
    appointment.appointment_date_time.strftime('%Y-%m-%dT%H:%M:%S')
  end

  def apt
    self.appointment
  end

  private

  def signing_key
    # This oddity is because I'm using Heroku and storing the secret key as string ENV variable
    @signing_key ||= OpenSSL::PKey::RSA.new(ENV["GSA_PRIVATE_KEY"].gsub("\\n", "\n"), 'notasecret')
  end


end
