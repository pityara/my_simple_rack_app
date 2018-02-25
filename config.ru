require 'rubygems'
require 'bundler'
require 'sprockets'
project_root = File.expand_path(File.dirname(__FILE__))

assets = Sprockets::Environment.new(project_root) do |env|
  env.logger = Logger.new(STDOUT)
end

assets.append_path(File.join(project_root, 'app', 'assets'))
assets.append_path(File.join(project_root, 'app', 'assets', 'javascripts'))
assets.append_path(File.join(project_root, 'app', 'assets', 'stylesheets'))
assets.append_path(File.join(project_root, 'app', 'assets', 'images'))

map "/assets" do
  run assets
end


Bundler.require

require "./app"

run App.new
