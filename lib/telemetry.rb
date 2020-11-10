require_relative '../lib/client'
require 'byebug'

class TelemetryDiagnostics
  attr_reader :diagnostic_info
  DIAGNOSTIC_CHANNEL_CONNECTION_STRING = "*111#"

  def initialize
    @telemetry_client = TelemetryClient.new
    @diagnostic_info = ""
  end

  def check_transmission
    @diagnostic_info = ""
    @telemetry_client.disconnect

    retry_left = 3
    # 1) if client is offline, client will try to reconnect up to 3 times
    # Diagnostic_channel_connection_string: what is called when you're trying to connect (offline and trying to reconnect)
    while (not @telemetry_client.online_status) and retry_left > 0
      @telemetry_client.connect(DIAGNOSTIC_CHANNEL_CONNECTION_STRING)
      retry_left -= 1
    end
    # if it fails to connect, it will raise an exception
    if not @telemetry_client.online_status
      raise Exception.new("Unable to connect.")
    end
    # if client is online, client will call Diagnostics
    @telemetry_client.send(TelemetryClient::DIAGNOSTIC_MESSAGE)
    @diagnostic_info = @telemetry_client.receive
  end
end
