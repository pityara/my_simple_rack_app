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
    if method == "GET"
      query.empty? ? send(action) : send(action, query) #invokes method
      build_response render
    elsif method == "POST"
      if response = send(action, body)
        build_post_response response
      else
        redirect_to "/"
      end
    end
    self
  end

  def not_found
    build_response "Page Not Found", status: 404
    self
  end

  def internal_error
    build_response "Internal error", status: 500
    self
  end


  private


  def build_post_response(body, status: 200)
    self.status = status
    self.headers = { "Content-Type" => "text/html" }
    self.content = [body]
  end

  def render_with_layout(file_path)
    content = Slim::Template.new(file_path).render(self)
    layout.render(self){ content }
  end


  def render
    file_path = File.join(App.root, 'app', 'views', "#{self.name}", "#{self.action}.slim")
    if File.exists?(file_path)
      p "Rendering template file #{self.action}.slim"
      render_with_layout(file_path)
    else
      "Error. Template file does not exist"
    end
  end

  def render_partial(template_file)
    file_path = File.join(App.root, 'app', 'views', "#{self.name}", template_file)
    if File.exists?(file_path)
      p "Rendering partial file #{self.action}.slim"
      render_without_layout(file_path)
    else
      "Error. Template file does not exist"
    end
  end

  def render_without_layout(file_path)
    Slim::Template.new(file_path).render(self)
  end

  def build_response(body, status: 200)
    self.status = status
    self.headers = { "Content-Type" => "text/html" }
    self.content = [body]
  end

  def redirect_to(uri)
    self.status = 302
    self.headers = { "Location" => uri }
    self.content = []
  end

end
