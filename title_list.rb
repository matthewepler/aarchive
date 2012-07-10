require './app.rb'

cans = Can.all
translation = " "
cans.each do |this|
  puts "#{this.canType}" << "#{this[:canNum]}" << " - " << "#{this[:titleEnglish]}"
end




