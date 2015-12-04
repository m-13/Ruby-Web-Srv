require 'socket'
require_relative 'HTTPRequest'
require_relative 'HttpResponse'

server = TCPServer.new("localhost", 13131)

while true do
	Thread.start(server.accept) do |client|
		request = HTTPRequest.new(client.gets)
		print request.requestStringprint "#{request.process.responseString}\n"
		client.print "#{request.process.responseString}"
		client.close
	end
end
