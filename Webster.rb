require 'socket' 
require_relative 'HTTPRequest'
require_relative 'HttpResponse'

server = TCPServer.new("localhost", 13131)

while true do
	Thread.start(server.accept) do |client|
		request = HTTPRequest.new(client.gets)	
		puts request.requestString
		client.puts request.process.response
		puts request.requestURI.sub("/","")
		client.close
	end
end
