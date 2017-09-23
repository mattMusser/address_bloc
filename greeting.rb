def greeting
  first_word = ARGV.delete(ARGV[0])
  ARGV.each do |name|
    p  first_word + " " + name
  end
end

greeting
