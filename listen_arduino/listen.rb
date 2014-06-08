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

last_i = ""

while true do
  while (i = sp.gets) do
    break if not i
    i.chomp!

    # Only run the update code if the state changed
    break if i == last_i
    last_i = i

    if i == "low"
      state = "open"
    else
      state = "closed"
    end
    puts "#{i}/#{state}"

    Net::HTTP.get(URI(
      "https://cssadoor.herokuapp.com/update_state?token=#{secret_token}&state=#{state}"
    ))
  end
end

sp.close
