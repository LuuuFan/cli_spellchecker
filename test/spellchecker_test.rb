require 'test/unit'
require_relative '../lib/spellchecker'
require_relative '../lib/trie'


class SpellCheckerTest < Test::Unit::TestCase

	def setup
		@dictionary = Trie.new
		['cat', 'cake', 'dog', 'sun', 'grass'].each do |word|
			@dictionary.insert(word)
		end
	end

	def test_valid_word
		res = spellcheck(@dictionary, ['cat'])
		assert(res.eql?('cat'), "Expected result as 'cat', but got #{res}")
	end

	def test_mis_spelling_word
		res = spellcheck(@dictionary, ['cet', 'case', 'son', 'glass'])
		assert(res.split(' ')[0].eql?('cat'), "Expected result as 'cat', but got #{res.split(' ')[0]}")
		assert(res.split(' ')[1].eql?('cake'), "Expected result as 'cake', but got #{res.split(' ')[1]}")
		assert(res.split(' ')[2].eql?('sun'), "Expected result as 'sun', but got #{res.split(' ')[2]}")
		assert(res.split(' ')[3].eql?('grass'), "Expected result as 'grass', but got #{res.split(' ')[3]}")
	end

end	