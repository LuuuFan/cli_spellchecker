require 'test/unit/ui/console/testrunner'
require_relative 'edit_distance_test'
require_relative 'trie_test'

Test::Unit::UI::Console::TestRunner.run(EditDistanceTest)
Test::Unit::UI::Console::TestRunner.run(TrieTest)