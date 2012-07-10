require './app.rb'

cans = Can.all
translation = " "
open('./outputs/titles_list.txt', 'w') { |f|
	cans.each do |this|
  		f.puts "#{this.canType}" << "#{this[:canNum]}" << " - " << "#{this[:titleEnglish]}"
  	end
}



