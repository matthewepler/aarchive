#thumbscript2

# puts URL for thumbnails into the "link1" property for each Can

require 'rubygems'
require 'dm-core'
require 'dm-migrations'
require 'dm-sqlite-adapter'
require 'picasa'
require './model.rb'

username = "118319050543607777197"
puts "Contacting Picasa..."
total = 0

albums = Picasa.albums :google_user => username

albums.each do |album|

	#get the thumbnail, save it
	#get the albumbURL
	#find the Can with a matching albumURL
	#update it's :line1 field with the thumbnail address
	#save the Can
    
	begin 
		album[:title].include? "mm"
		album_string = album[:title]
		thumb = album[:thumbnail]
		can_type, can_num = album_string.split(" #")

		thisCan = Can.first(:canNum => can_num.to_i, :canType => can_type)

	   	puts "processing thumbnail for #{thisCan.canNum}"
		puts "URL = #{album[:thumbnail]}"
		puts "======================================"
	    
	    thisCan.update(:link1 => thumb)
		thisCan.save
		total = total + 1
	rescue Exception=>e
		puts album[:title] + "__*****ERROR*******"

end
    diff = albums.size - total
	puts "Total albums =  #{albums.size}"
	puts "Total albums processed = #{total}"
	puts "Total Errors = #{diff}"

 end