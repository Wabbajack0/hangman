class Guess
  attr_accessor :guess_state, :solution

  @@words = File.readlines("dictionary.txt")

  # Picks a random word from the dictionary.txt file and create the guess_state
  # variable with underscores
  def initialize
    @solution = @@words[rand(@@words.length)].downcase.strip
    @guess_state = ""
    @solution.length.times { @guess_state << "_ " }
    @already_asked = []
  end

  # Takes the guess letter, updates the guess_state variable if the letter is included
  # and returns true if the user won (otherwise returns false). It also returns
  # true or false if at least a letter has been found
  def next_guess(letter)
    i = 0
    found = false

    if @already_asked.include?(letter)
      puts "You already tried this letter!"
      return false, true
    end

    @solution.each_char do |sol_letter|
      if sol_letter == letter
        @guess_state[i] = letter
        found = true
      end
      @already_asked << letter
      i += 2  # doesn't count spaces between underscores
    end

    if @guess_state == @solution
      return true, found
    else
      return false, found
    end
  end
end
