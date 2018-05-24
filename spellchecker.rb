#!/usr/bin/env ruby
require 'byebug'
require_relative 'edit_distance'

def spellcheck
	dict = Hash.new
	File.open('/usr/share/dict/words'){|f| f.each_line{ |l| dict[l.split("\n")[0]] = true}}
	
	result  = []
	words = ARGV

	while words.empty?
		p "Please input a word"
		words = gets.chomp.split(/\W+/)
	end


	words.each do |a|
		if dict[a.downcase]
			result << a
		else
	  		smallest_distance = 2 ** 32
			result_word = ""
	  		dict.keys.each do |w|
	  			distance = edit_distance(a.downcase, w)
	  			if distance <= smallest_distance
	  				smallest_distance = distance
	  				result_word = w
	  			end
	  		end
	  		result << result_word
		end
 	end

 	if result.join(' ') != words.join(' ')
 		p 'Do you mean?'
 	end

	p result.join(' ')
end

spellcheck
