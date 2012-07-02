require 'rubygems'
require 'dm-core'
require 'dm-migrations'
require 'dm-sqlite-adapter'
require 'picasa'
require './model.rb'

username = "118319050543607777197"

 # goes over the internet

albums.each do |album|
  puts
  # puts "found album: #{album[:id]}"
  # puts "=========================="
  puts album[:title]

  a = Can.new
  
  album_string = album[:title]
  a.canType, a.canNum = album_string.split(" #") # ["Small 16mm", "2"]
  
  a.albumURL = album[:slideshow].split("#")[0]
  a.save
  #puts a.inspect

  result = Picasa.photos(:google_user => username, :album_id => album[:id])  # goes over the internet
  
    # assume the first photo is the can label
    photo = result[:photos][0]
        
    parts = photo[:thumbnail_1].split("/")
    parts[parts.length - 2] = "s1600"
    url = parts.join("/")
    a.imageURL = url
    a.save
    # puts "photo url: #{url}"
    

end

