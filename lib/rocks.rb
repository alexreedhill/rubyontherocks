require 'rocks/version'
require 'rocks/routing'
require 'rocks/array'
require 'rocks/util'
require 'rocks/dependencies'
require 'rocks/controller'
require 'rocks/file_model'

	module Rocks
		class Application
			def call(env)
				if env['PATH_INFO'] == '/favicon.ico'
					return [404,
				 		{'Content-Type' => 'text/html'}, []]
				end
				klass, action = get_controller_and_action(env)
				controller = klass.new(env)
				locals = controller.send(action)
				if controller.get_response
					st, hd, rs = controller.get_response.to_a
					[st, hd, [rs.body].flatten]
				else
					controller_name = env["PATH_INFO"].split('/', 4)[1]
					if locals.is_a? Array
						locals = { controller_name => locals }
					elsif locals.class != Hash && locals.class != Array
						locals = { controller_name[0..-2] => locals }
					end
					st, hd, rs = controller.render_response(action, locals).to_a
					[st, hd, [rs.body].flatten]
				end
			end
		end

	end
