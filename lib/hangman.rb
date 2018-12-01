require_relative "guess.rb"

game = Guess.new
lives = 6
has_won = false

puts "Welcome to Hangman!"

while lives != 0
  puts "\nType your next guess, type save to save the game or type load to load another game"
  str = gets.chomp.downcase
  while str.length != 1 && !str.match?(/save/) && !str.match?(/load/)
    puts "Wrong input, try again"
    str = gets.chomp.downcase
  end

  case str
  when "save"
    game.save(lives)
    break
  when "load"
    lives = game.load
  else
    has_won, found = game.next_guess(str)
    if !found
      lives -= 1
      puts "Your letter is not included, you lose a life."
      puts "Remaining lives: #{lives}"
    end
    if has_won
      puts "You won!"
      break
    end
    puts game.guess_state
  end
end

if lives == 0
  puts "You lost."
  puts "The solution was #{game.solution}"
end
