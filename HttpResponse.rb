

class HttpResponse
		attr_accessor :responseString , :statusLine , :responseHeaders , :responseBody , :httpRequest

	def initialize(httpRequest)
		@httpRequest = httpRequest
	end

end
