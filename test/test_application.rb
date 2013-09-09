require_relative 'test_helper'

class TestController < Rocks::Controller

	def index
		"Hello!"
	end

end

class TestApp < Rocks::Application

	def get_contoller_and_action(env)
		[TestController, "index"]
	end

end


class Rocks < Test::Unit::TestCase
	include Rack::Test::Methods

	def app
		TestApp.new
	end

	def test_request
		get '/test/index'

		assert last_response.ok?
		body = last_response.body
		assert body["Hello"]
	end

	def test_post
		post '/test/index'

		assert last_response.ok?
	end
end