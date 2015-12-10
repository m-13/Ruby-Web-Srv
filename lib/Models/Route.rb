
class Route
  attr_reader :pattern
  def initialize(pattern, app, controller, action, params)
    @pattern = pattern
    @app = app
    @controller = controller
    @action = action
    @params = params
  end
  def get
    [@app, @controller, @action, @params]
  end
end
