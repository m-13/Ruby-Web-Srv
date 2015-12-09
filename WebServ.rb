require 'socket'
require_relative 'HttpRequestHandler'

server = TCPServer.new("localhost",13131)

while true do
  Thread.start(server.accept) do |client|
    request, ip = client.recvfrom(4096)
    handler = HttpRequestHandler.new(request)
    handler.processRequest
    # puts handler.httpResponse.response
    client.puts handler.httpResponse.response
    client.close
  end
end
