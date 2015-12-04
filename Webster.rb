require 'socket'
require_relative 'HTTPRequest'
require_relative 'HttpResponse'

server = TCPServer.new("localhost", 13131)

while true do
	Thread.start(server.accept) do |client|
		request = HTTPRequest.new(client.gets)
		print request.requestString
		# response = request.process
		client.puts "#{request.process.responseString}"
	  puts "#{request.process.responseString}\n from webServer"

		client.close
	end
end
