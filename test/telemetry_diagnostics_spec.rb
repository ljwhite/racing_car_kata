require_relative '../lib/telemetry'

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

describe TelemetryDiagnostics do
  context "#diagnostic_info" do
    it "returns the correct diagnostic info" do
      expect(TelemetryDiagnostics.new.diagnostic_info).to eq ""
    end
  end

  context "#check_transmission" do
    before do
      allow_any_instance_of(TelemetryClient).to receive(:online_status) { status }
    end

    context 'when client is online' do
      let(:status) { true }

      it "check_transmission status" do
        obj = TelemetryDiagnostics.new
        expect(obj.check_transmission).to eq(TRANSMISSION_RESPONSE)
      end
    end

    context 'when client is offline' do
      let(:status) { false }

      it 'raises an exception' do
        obj = TelemetryDiagnostics.new
        expect {obj.check_transmission}.to raise_error(Exception)
      end
    end
  end
end
