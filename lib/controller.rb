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
      self.content = [render_template]
    elsif method == "GET"
      send(action) #invokes method
      self.status = 200
      self.headers = { "Content-Type" => "text/html" }
      self.content = [render_template]
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


  private

  def render_template
    file_path = File.join(App.root, 'app', 'views', "#{self.name}", "#{self.action}.slim")
    if File.exists?(file_path)
      p "Rendering template file #{self.action}.slim"
      render_slim_file(file_path)
    else
      "Error. Template file does not exist"
    end
  end

  def render_partial(template_file)
    file_path = File.join(App.root, 'app', 'views', "#{self.name}", template_file)
    if File.exists?(file_path)
      p "Rendering partial file #{self.action}.slim"
      render_slim_file(file_path)
    else
      "Error. Template file does not exist"
    end
  end

  def render_slim_file(file_path)
    Slim::Template.new(file_path).render(self)
  end



end
