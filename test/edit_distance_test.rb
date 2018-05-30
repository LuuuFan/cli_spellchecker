require 'test/unit'
require_relative '../lib/edit_distance'

class EditDistanceTest < Test::Unit::TestCase
	
	def test_total_match
		res = edit_distance('word', 'word')
		assert(res.eql?(0), "Expected 0 but was #{res}")
	end

	def correct_modified_steps
		res = edit_distance('cat', 'cake')
		assert(res.eql?(2), "Expected 2 but was #{res}")
	end

end
