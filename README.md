# Ruby-Web-Srv
implemented fetch from db on the same web server. 

To run: ruby Webster.rb

The server runs on port 13131, which is not configurable at the moment. 
You can use any web browser to send requests. 

sample: localhost:13131/order/[id]
output: responds with data from database with id = [id]

you'll need to create mysql database before running. 
