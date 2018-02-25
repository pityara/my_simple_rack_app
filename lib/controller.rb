class Controller
  attr_reader :name, :action, :method, :query, :body
  attr_accessor :status, :headers, :content

  def  initialize(name: nil, action: nil, method: nil, body: nil, query: nil)
    @name = name
    @action = action
    @method = method
    @body = body
    @query = query
  end

  def call
    if (method == "GET" && query!={})
      send(action, query) #invokes method
      self.status = 200
      self.headers = { "Content-Type" => "text/html" }
      self.content = [template.render(self)]
    elsif method == "GET"
      send(action) #invokes method
      self.status = 200
      self.headers = { "Content-Type" => "text/html" }
      self.content = [template.render(self)]
    elsif method == "POST" && body
      send(action, body)
      self.status = 200
      self.headers = { "Content-Type" => "text/html" }
      self.content = ["<meta charset='utf-8'><a href='/'>На главную</a><p>Successfully created!"]
    end
    self
  end

  def not_found
    self.status = 404
    self.headers = {}
    self.content = ["Not found"]
    self
  end

  def internal_error
    self.status = 500
    self.headers = {}
    self.content = ["Internal error"]
    self
  end

  def template
    Slim::Template.new(File.join(App.root, 'app', 'views', "#{self.name}", "#{self.action}.slim"))
  end
end
