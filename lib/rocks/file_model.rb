require 'multi_json'
require 'pry'

module Rocks
	module Model
		class FileModel

			def initialize(filename)
				@filename = filename

				#If filename is dir/710.json, @id is 710
				basename = File.split(filename)[-1]
				@id = File.basename(basename, ".json").to_i

				obj = File.read(filename)
				@hash = MultiJson.load(obj)
			end

			def [](name)
				@hash[name.to_s]				
			end

			def []=(name, value)
				@hash[name.to_s] = value
			end

			def self.all
				files = Dir["db/quotes/*.json"]
				files.map { |f| FileModel.new f }
			end

			def self.find(id)
				begin
					FileModel.new("db/quotes/#{id}.json")
				rescue
					return nil
				end
			end

			def self.find_all_by_submitter(env)
				files = Dir["db/quotes/*.json"]
				file_models = files.map { |f| FileModel.new f }
				submitter = env['PATH_INFO'].gsub('/quotes/submitter/', '').gsub('%20', '_')
				Array(file_models.collect { |f| f if f['submitter'].gsub(' ', '_') == submitter }.compact)
			end

			def self.create(attrs)
			    hash = {}
			    hash["submitter"] = attrs["submitter"] || ""
			    hash["quote"] = attrs["quote"] || ""
			    hash["attribution"] = attrs["attribution"] || "" 

			    files = Dir["db/quotes/*.json"]
			    names = files.map { |f| f.split("/")[-1] }
			    highest = names.map { |b| b[0...-5].to_i }.max
			    id = highest + 1

			    File.open("db/quotes/#{id}.json", "w", hash) do |f|
			      f.write MultiJson.dump(hash)
					end
			  FileModel.new "db/quotes/#{id}.json"
			end

			def self.save(env)
				id = 1
				if env["REQUEST_METHOD"] == 'POST'
					quote = FileModel.find(id)
					hash = {}
					hash["submitter"] = "Alexander"
					hash["quote"] = quote["quote"] || ""
					hash["attribution"] = quote["attribution"] || "" 
					File.open("db/quotes/#{id}.json", "w", hash) do |f|
						f.write MultiJson.dump(hash)
					end
				end
				FileModel.new "db/quotes/#{id}.json"
			end

		end
	end
end
