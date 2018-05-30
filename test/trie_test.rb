require 'test/unit'
require_relative '../lib/trie'

class TrieTest < Test::Unit::TestCase
	
	def setup
		@dictionary = Trie.new
		['cat', 'cake', 'dog', 'sun', 'grass'].each do |word|
			@dictionary.insert(word)
		end
	end	

	def test_insert
		@dictionary.insert('shasha')
		res = @dictionary.root.children['s'] ? true : false
		assert(res.eql?(true), "Expected dictionary's root has 's'")
	end	

	def test_search_true
		res = @dictionary.search('cat')
		assert(res.eql?(true), "Expected true but was #{res}")
	end

	def test_search_false
		res = @dictionary.search('cta')
		assert_equal(false, res, "Expected false but was #{res}")
		# assert(res.eql?(false), "Expected false but was #{res}")
	end

	def test_starts_with_true
		res = @dictionary.starts_with('ca')
		assert(res.eql?(true), "Expected true but was #{res}")	
	end

	def test_starts_with_false
		res = @dictionary.starts_with('a')
		assert(res.eql?(false), "Expected false but was #{res}")
	end

	def test_find_possible_words_true
		res = @dictionary.find_possible_words('ca')
		assert(res.length.eql?(2), "Expected to find 2 possible words for 'ca', but got #{res}")	
	end

	def test_find_possible_words_false
		res = @dictionary.find_possible_words('sa')
		assert(res.length.eql?(0), "Expected there is no possible word for 'sa', but got #{res}")
	end

	def test_find_prefix_has_prefix
		res = @dictionary.find_prefix('capital')
		assert(res.eql?('ca'), "Expected that prefix for capital is 'ca', it was #{res}")
	end

	def test_find_prefix_has_no_prefix
		res = @dictionary.find_prefix('shasha')
		assert(res.eql?(""), "Expected there is no prefix for 'shasha, it was #{res}")
	end

	def test_print_trie
		res = @dictionary.print_trie
		assert(res.length.eql?(5), "Expected return all the words in trie, it was #{res}")
	end

end
