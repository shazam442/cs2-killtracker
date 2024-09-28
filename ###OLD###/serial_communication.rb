require 'rubygems'
require 'rubyserial'


serial_port = Serial.new 'COM3', 9600, 8

message = "Hello from Ruby!\n"
serial_port.write(message)

sleep 1 # Wait for 1 second to ensure data is sent and processed
response = serial_port.read(100)

puts response

# Close the serial port when done
serial_port.close
