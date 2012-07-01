#thumbscript2

# puts URL for thumbnails into the "link1" property for each Can

require 'rubygems'
require 'dm-core'
require 'dm-migrations'
require 'dm-sqlite-adapter'
require 'picasa'
require './model.rb'
require 'open-uri'

username = "118319050543607777197"
puts "Contacting Picasa..."
total = 0

albums = Picasa.albums :google_user => username
# FileUtils.mkdir ("thumb_images")

albums.each do |album|

	#get the thumbnail, save it
	#get the albumbURL
	#find the Can with a matching albumURL
	#update it's :line1 field with the thumbnail address
	#save the Can
    
	begin 
		if album[:title].include? "mm" 
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
		end

	rescue Exception=>e
		puts album[:title] + "__*****ERROR*******"
		puts e

	end


	Dir.chdir("/Users/matthewepler/Documents/RFC film Project Summary/Website Files Archive/final/thumb_images")
	open(thumb) {|f|
   		File.open(album_string + ".jpg", "wb") do |file|
    	file.puts f.read
   		end
	} 	 
	puts "we did it, dude!"
end

 #    diff = albums.size - total
	# puts "Total albums =  #{albums.size}"
	# puts "Total albums processed = #{total}"
	# puts "Total Errors = #{diff}"
