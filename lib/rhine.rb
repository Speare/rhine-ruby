require 'net/http'
require 'uri'
require 'json'

module Rhine
	class Instance
		def self.get_response(method, apikey)
			uri = URI.parse("http://api.rhine.io")
			request = Net::HTTP::Post.new("/", initheader = {'Content-Type' =>'application/json'})
			request.body = {'request' => {'method' => method, 'key' => apikey}}.to_json
			# get it
			r = Net::HTTP.new(uri.host, uri.port).request(request)
			if r.code == "301"
				redirect = URI.parse(r.header['location'])
				r = Net::HTTP.new(redirect.host, redirect.port).request(request)
			end
			result = JSON.parse(r.body)
			if result.has_key?("failure")
				raise "Failure"
			end
			result["success"]
		end
		
		def initialize apikey
			@apikey = apikey
		end

		def run method
			self.class.get_response(method, @apikey)[method.keys[0]]
		end

		def pipeline methods
			self.class.get_response({'pipelined' => methods}, @apikey)
		end
	end

	class Functions
		def self.extraction o
			return {'extraction'=> o}
		end
		def self.closest o
			return {'closest' => o}
		end
		def self.equivalence x, y
			return {'equivalence' => [x, y]}
		end
		def self.subclass x, y
			return {'subclass' => [x, y]}
		end
		def self.distance x, y
			return {'distance' => [x, y]}
		end
		def self.clustering os
			return {'clustering' => os}
		end
	end

	class Datatypes
		class Article
			def self.fromurl url
				return {'article' => {'fromurl' => url}}
			end
		end
		class Iamge
			def self.fromurl url
				return {'image' => {'fromurl' => url}}
			end
		end

		def self.text o
			return {'text' => o}
		end
		def self.entity o
			return {'entity' => o}
		end
		def self.grouped os
			return {'grouped' => os}
		end
	end
end
