

class HttpResponse

		attr_reader :response , :statusLine , :responseHeaders , :responseBody , :httpRequest

	def initialize(httpRequest)
		@httpRequest = httpRequest
		case httpRequest.requestMethod
		when "GET"
			httpGetResponse
		else
			createResponse(501)
		end
	end

	def httpGetResponse
		if(resourceAvailable?)
			if(conditionsMatch?)
				createResponse(200)
			else
				createResponse(304)
			end
		else 
			createResponse(404)
		end
	end

	def createResponse(statusCode)
		case statusCode
		when 200
			@statusLine = httpRequest.requestVersion+" "+"200"+" "+"Ok"
			@responseHeaders=""
			fetchResponseBody
		when 302
			@statusLine = httpRequest.requestVersion+" "+"304"+"Not Modified"
			@responseHeaders=""
			@responseBody=""
		when 404
			@statusLine = httpRequest.requestVersion+" "+"404"+" "+"Not Found"
			@responseHeaders=""
			@responseBody="<H1>Page not found</H1>"
		else 
			@statusLine = httpRequest.requestVersion+" "+"501"+"Not Implemented"
			@responseHeaders=""
			@responseBody="<H1>This functionality is still not implemented on the server</H1>"

		end

		@response = statusLine+"\n"+responseHeaders+"\r\n"+"\r\n"+responseBody
	end

	def fetchResponseBody
		if(resourceAvailable?)
			resource = File.open(httpRequest.requestURI.sub("/",""),"r")
			content = resource.read
			@responseBody = content
		end
	end

	def resourceAvailable?
		if(File.file?(httpRequest.requestURI.sub("/","")))
			return true
		else 
			return false
		end
	end

	def conditionsMatch?
		#TODO: change method to check for preconditions on headers
		return true
	end

end

