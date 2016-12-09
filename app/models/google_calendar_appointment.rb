class GoogleCalendarAppointment
  attr_accessor :appointment

  def initialize(appointment)
    @appointment = appointment
  end

  def initial_call(url)
    Signet::OAuth2::Client.new({
      client_id: CLIENT_ID,
      client_secret: CLIENT_SECRET,
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      scope: CALENDAR_SCOPE,
      redirect_uri: url
    })
  end

  def callback_obj(params, url)
    Signet::OAuth2::Client.new({
      client_id: CLIENT_ID,
      client_secret: CLIENT_SECRET,
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      redirect_uri: url,
      code: params[:code]
    })
  end

  def calendars(access_token)
    email_mail = self.appointment.stylist.email
    client = Signet::OAuth2::Client.new(access_token: access_token)
    client.expires_in = Time.now + 1_000_000
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    service.insert_event('primary', client_appointment)
  end

  def client_appointment
    Google::Apis::CalendarV3::Event.new({
    summary: 'New Appointment',
    location: 'Karma Salon',
    description: "Treatment Services #{apt.treatment_services || 'Not requested'}, Chemical Services #{apt.chemical_services || 'Not requested'},Color services #{apt.color_services || 'Non requested'}, Braid #{apt.braid || 'Not requested'}, Basic services #{apt.basic_services || 'Not requested'}, Weave #{apt.weave || 'Not requested'}",
    start: {
    date_time: "2016-12-30T00:00:00",
    time_zone: 'America/New_York',
    },
    end: {
      date_time: "2016-12-31T00:00:00",
      time_zone: 'America/New_York',
    }
    })
  end

  def apt
    self.appointment
  end
end
