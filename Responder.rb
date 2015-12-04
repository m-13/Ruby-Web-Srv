
class Responder
  attr_accessor :httpResponse , :httpRequest
  def initialize(httpRequest, httpResponse)
    self.httpRequest = httpRequest
    self.httpResponse = httpResponse
  end

  def fetchResponse
    
  end

  def response
    return httpResponse.responseString
  end

end
