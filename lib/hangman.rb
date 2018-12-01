require_relative "guess.rb"

game = Guess.new
lives = 6
has_won = false

puts "Welcome to Hangman!"

while lives != 0 && !has_won
  puts "\nType your next guess:"
  has_won, found = game.next_guess(gets.chomp.downcase)
  if !found
    lives -= 1
    puts "Your letter is not included, you lose a life."
    puts "Remaining lives: #{lives}"
  end
  puts game.guess_state
end

if has_won
  puts "You won!"
else
  puts "You lost."
  puts "The solution was #{game.solution}"
end
