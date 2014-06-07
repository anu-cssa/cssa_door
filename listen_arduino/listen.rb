require 'serialport'
require 'net/http'
require 'uri'

port_str = '/dev/tty.usbmodemfd121'
baud_rate = 9600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE

sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

secret_token = ENV["SECRET_TOKEN"]

# clear out the port
sp.gets

while true do
  while (i = sp.gets.chomp) do
    if i == "low"
      state = "open"
    else
      state = "closed"
    end
    puts "#{i}/#{state}"

    Net::HTTP.get(URI(
      "http://cssadoor.herokuapp.com/update_state?token=#{secret_token}&state=#{state}"
    ))
  end
end

sp.close
