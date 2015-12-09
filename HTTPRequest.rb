class HttpRequest
	attr_reader :request , :method , :uri , :version , :headers, :body
	def initialize(attrib)
		@request = attrib[:request]
		@method  = attrib[:method]
		@uri = attrib[:uri]
		@version = attrib[:version]
		@headers = attrib[:headers]
		@body = attrib[:body]
	end

	def requestLine
		"#{@method} #{@uri} #{@version}"
	end
end
