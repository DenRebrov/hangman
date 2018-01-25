class Game
  def initialize(slovo)
    @letters = get_letters(slovo)

    @errors = 0

    @good_letters =[]
    @bad_letters =[]

    @status = 0
  end

  def status
    @status
  end

  def get_letters(slovo)
    if slovo == nil || slovo == ""
      abort "Загадано пустое слово, нечего отгадывать. Закрываемся"
    end

    return slovo.encode('UTF-8').split("")
  end

  def ask_next_letter
    letter = ""

    while (letter == "") do
      puts "Введите букву"
      #letter = STDIN.gets.encode("UTF-8").downcase.chomp
      l = STDIN.gets.encode("UTF-8").chomp
      letter = UnicodeUtils.downcase(l)
    end
    next_step(letter)
  end

  def next_step(bukva)
    if @status == -1 || @status == 1
      return
    end

    if @good_letters.include?(bukva) || @bad_letters.include?(bukva)
      return
    end

    if @letters.include?(bukva) ||
      (bukva == "е" && @letters.include?("ё")) ||
      (bukva == "ё" && @letters.include?("е")) ||
      (bukva == "и" && @letters.include?("й")) ||
      (bukva == "й" && @letters.include?("и"))

      @good_letters << bukva

      if bukva == "е"
        good_letters << "ё"
      end

      if bukva == "ё"
        good_letters << "е"
      end

      if bukva == "и"
        good_letters << "й"
      end

      if bukva == "й"
        good_letters << "и"
      end

      if (@letters - @good_letters).empty?
        @status = 1
      else
        @status = 0
      end
    else
      @bad_letters << bukva
      @errors += 1

      if @errors >= 7
        @status = -1
      end
    end
  end

  def letters
    @letters
  end

  def good_letters
    @good_letters
  end

  def bad_letters
    @bad_letters
  end

  def errors
    @errors
  end
end