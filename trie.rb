
class TrieNode
    attr_accessor :children, :end_of_word

    def initialize()
        @children = Hash.new
        @end_of_word = false
    end
end

class Trie
    attr_reader :root

    # Initialize data structure.
    def initialize()
        @root = TrieNode.new()
    end


    # Inserts a word into the trie.
    # :type word: String
    # :rtype: Void
    def insert(word)
        current_node = @root
        word.chars.each do |char|
            node = current_node.children[char]
            if !node
                node = TrieNode.new();
                current_node.children[char] = node
            end
            current_node = node
        end
        current_node.end_of_word = true
    end


    # Returns if the word is in the trie.
    # :type word: String
    # :rtype: Boolean
    def search(word)
        current_node = @root
        word.chars.each do |char|
            if !current_node.children[char]
                return false
                break
            else
                current_node = current_node.children[char]
            end
        end
        return current_node.end_of_word ? true : false
    end


    # Returns if there is any word in the trie that starts with the given prefix.
    # :type prefix: String
    # :rtype: Boolean
    def starts_with(prefix)
        current_node = @root
        prefix.chars.each do |char|
            if !current_node.children[char]
                return false
                break
            else
                current_node = current_node.children[char]
            end
        end
        true
    end

    # 
    def find_possible_words(word)
        result = []
        prefix = ''
        current_node = @root
        word.chars.each do |char|
            prefix += char
            if !self.starts_with(prefix)
                break
            end
            current_node = current_node.children[char]
        end
        current_node.end_of_word ? [prefix].concat(get_sub_word(current_node, prefix)) : get_sub_word(current_node, prefix)
    end

    # function for finding valid prefix if word has been mis spelled
    def find_prefix(word)
        prefix = ''
        i = 0
        while starts_with(prefix)
            prefix += word[i]
            i += 1
        end
        prefix.slice(0, prefix.length - 1)
    end

    # function for find sub words for the one node
    def get_sub_word(node, prefix)
        return [] if !starts_with(prefix)
        keys = node.children.keys
        result = []
        keys.each do |char|
            if node.children[char].end_of_word
                result << prefix + char
            end
            result.concat(get_sub_word(node.children[char], prefix + char))
        end
        result
    end
end

