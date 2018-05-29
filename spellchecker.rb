#!/usr/bin/env ruby
require_relative 'edit_distance'
require_relative 'trie'

def spellcheck(dict, words)
	# initialize the result as empty array 
	result  = []

	words.each do |word|
		if dict.search(word)
			# if it's a valid word in dictionary, then just push it into result
			result << word
		else
			# find the break point of miss spelling
	  		prefix = dict.find_prefix(word)
	  		# git all the possible words in dict for prefix
	  		possible_words = dict.find_possible_words(prefix)
			# initialize the result_word
			result_word = ""
	  		# initialize smallest distance as inifinite
	  		smallest_distance = 2 ** 32
	  		# loop in the possible words to find the most similar word
	  		possible_words.each do |w|
	  			# using edit_distance algrithm to find the lowest steps that need to be modified become a word in dictionary
	  			distance = edit_distance(word.downcase, w)

	  			if distance <= smallest_distance
	  				smallest_distance = distance
	  				result_word = w
	  			end
	  		end
	  		# push the most similar word into result array
	  		result << result_word
		end
 	end

 	# return result as a sentence
	result.join(' ')
end

def load_dictionary
	dictionary = Trie.new()
	# go through the dict file, to build dictionary
	File.open('/usr/share/dict/words'){|f| f.each_line{ |l| dictionary.insert(l.split("\n")[0])}}
	dictionary
end

def get_words_to_check
	# get words from ARGV input
	words = ARGV

	# if there is no valid ARGV, then ask a valid word to check'
	while words.empty?
		p "Please input a word"
		# make words as array, in case there is multiple words input
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
