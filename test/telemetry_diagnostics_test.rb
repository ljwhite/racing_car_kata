require "minitest/autorun"
require_relative '../lib/telemetry'
require 'byebug'

class TelemetryDiagnosticsTest < Minitest::Test

TRANSMISSION_RESPONSE = "
LAST TX rate................ 100 MBPS\r\n
HIGHEST TX rate............. 100 MBPS\r\n
LAST RX rate................ 100 MBPS\r\n
HIGHEST RX rate............. 100 MBPS\r\n
BIT RATE.................... 100000000\r\n
WORD LEN.................... 16\r\n
WORD/FRAME.................. 511\r\n
BITS/FRAME.................. 8192\r\n
MODULATION TYPE............. PCM/FM\r\n
TX Digital Los.............. 0.75\r\n
RX Digital Los.............. 0.10\r\n
BEP Test.................... -5\r\n
Local Rtrn Count............ 00\r\n
Remote Rtrn Count........... 00"

  def test_it_can_initialize
    skip 
    ex = TelemetryDiagnostics.new
    assert_equal ex.diagnostic_info, ""
  end

  def test_check_transmission
    skip
    ex = TelemetryDiagnostics.new

    client = TelemetryClient.new
    ex.stub(:online_status, true) do
      assert_equal true, client.online_status

      assert_equal TRANSMISSION_RESPONSE, ex.check_transmission
    end
  end
end
