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
    if @already_asked.include?(letter)
      puts "You already tried this letter!"
      return false, true
    end

    i = 0
    found = false
    @already_asked << letter

    @solution.each_char do |sol_letter|
      if sol_letter == letter
        @guess_state[i] = letter
        found = true
      end
      i += 2  # doesn't count spaces between underscores
    end

    return @guess_state.gsub(/\s+/, "") == @solution, found
  end

  # Saves in a file the game. Takes as parameter the number of lives left
  def save(lives)
    puts "Name of the save file?"
    str = gets.chomp

    save_file = File.open("saves/#{str}.txt", "w")
    save_file.puts @solution
    save_file.puts @guess_state
    save_file.puts lives
    save_file.puts @already_asked.join(",")
    save_file.close
    puts "Game saved."
  end

  # Loads the file and returns the number of lives
  def load
    puts "Name of the save file to load?"
    str = gets.chomp
    save_file = File.readlines("saves/#{str}.txt")
    @solution = save_file[0].strip
    @guess_state = save_file[1].strip
    @already_asked = save_file[3].strip.split(",")
    return save_file[2].strip.to_i
  end
end
