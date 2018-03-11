require 'yaml'
require "./lib/boot"
require "./lib/router"

class App
  def self.root
    File.dirname(__FILE__)
  end
  attr_reader :router

  def initialize
    @router = Router.new(ROUTES)
  end

  def call(env)
    result = router.resolve(env)
    [result.status, result.headers, result.content]
  end
end
