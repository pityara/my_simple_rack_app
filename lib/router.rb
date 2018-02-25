class Router
  attr_reader :routes

  def initialize(routes)
    @routes = routes
  end

  def resolve(env)
    path = env['REQUEST_PATH']
    verb = env['REQUEST_METHOD']
    query = parse_query(env['QUERY_STRING'])
    body = parse_body(env['rack.input'].read)
    if routes.key?(path)
      ctrl(routes[path], verb, body, query).call
    else
      Controller.new.not_found
    end
    rescue Exception => error
      puts error.message
      puts error.backtrace
      Controller.new.internal_error
  end
  private def ctrl(string, method, body, query)
    ctrl_name, action_name = string.split('#')
    klass = Object.const_get "#{ctrl_name.capitalize}Controller"
    klass.new(name: ctrl_name, action: action_name.to_sym, method: method, body: body, query: query)
  end
  private def parse_body(query)
    query = URI.decode(query)
    query.gsub!("+", " ")
    parse_query(query)
  end
  private def parse_query(query)
    Hash[ query.split('&').map { |x| x.split('=') } ]
  end
end
