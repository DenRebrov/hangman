if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require "unicode_utils/downcase"

require_relative "game"
require_relative "result_printer"
require_relative "word_reader"

current_path = File.dirname(__FILE__)

printer = ResultPrinter.new

reader = WordReader.new

words_file_name = current_path + "/data/random_word.txt"

game = Game.new(reader.read_from_file(words_file_name))

while game.status == 0 do
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)
