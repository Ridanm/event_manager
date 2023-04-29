require 'erb'

meaning_of_life = 42

question = "The Answer to the Ultimate Questionof Life, Universe, and Everything is <%= meaning_of_life%>"
template = ERB.new question 

result = template.result(binding)
puts result 