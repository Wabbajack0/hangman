dictionary = File.open("dictionary.txt", "w")
words = File.readlines("words.txt")

words.each do |word|
  if word.length < 12 && word.length > 5
    dictionary.puts word
  end
end

dictionary.close
