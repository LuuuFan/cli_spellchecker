#!/usr/bin/env ruby
# require 'byebug'
require_relative 'edit_distance'
require_relative 'trie'

def spellcheck(dict, words)
		
	result  = []

	words.each do |word|
		if dict.search(word)
			result << word
		else
	  		prefix = dict.find_prefix(word)
	  		possible_words = dict.find_possible_words(prefix)
			result_word = ""
	  		smallest_distance = 2 ** 32
	  		possible_words.each do |w|
	  			distance = edit_distance(word.downcase, w)
	  			if distance <= smallest_distance
	  				smallest_distance = distance
	  				result_word = w
	  			end
	  		end
	  		result << result_word
		end
 	end

	result.join(' ')
end

def load_dictionary
	dictionary = Trie.new()
	File.open('/usr/share/dict/words'){|f| f.each_line{ |l| dictionary.insert(l.split("\n")[0])}}
	dictionary
end

def get_words_to_check
	# get words from ARGV input
	words = ARGV

	# if there is no valid ARGV, then ask a valid word to check'
	while words.empty?
		p "Please input a word"
		words = gets.chomp.split(/\W+/)
	end
	
	words
end

def run
	valid_words = load_dictionary
	words_to_check = get_words_to_check

	results = spellcheck(valid_words, words_to_check)
	p results
end

if __FILE__ == $0
	run
end
