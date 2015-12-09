class HttpResponse
		attr_reader  :version , :statusCode , :statusMsg , :headers , :body

	def initialize(httpRequest , code , response=nil)
		@version = httpRequest.version
		@statusCode = code
		@headers = ""
		case code
		when 200
			@statusMsg = "Ok"
			@body = response
		when 404
			@statusMsg = "Not Found"
			@body = notFound
		else
			@code = 501
			@statusMsg = "Not Implemented"
			@body = "This is not implemented yet"
		end
	end

	def statusLine
		"#{@version} #{@statusCode} #{@statusMsg}"
	end
	def response
		"#{statusLine}\r\n#{@headers}\r\n\r\n#{@body}"
	end

	private def notFound
		"404 Not Found"
	end
end
