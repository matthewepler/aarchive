require 'bundler'
Bundler.require
require './model.rb'

get '/' do
  <<-HTML
<link rel="stylesheet" type="text/css" href="/final.css"/>
<body class="black">
<div id="home-images">
<img src="/frame_16.jpg" width="300" height="200">
<img src="/frame_2.jpg" width="300" height="200">
<img src="/frame_13.jpg" width="300" height="200">
<img src="/frame_12.jpg" width="300" height="200">
<img src="/frame_17.jpg" width="300" height="200">
<img src="/frame_9.jpg" width="300" height="200">
<img src="/frame_10.jpg" width="300" height="200">
<img src="/frame_7.jpg" width="300" height="200">
<img src="/frame_6.jpg" width="300" height="200">
<img src="/frame_18.jpg" width="300" height="200">
<img src="/frame_3.jpg" width="300" height="200">
<img src="/frame_8.jpg" width="300" height="200">
<img src="/frame_4.jpg" width="300" height="200">
<img src="/frame_5.jpg" width="300" height="200">
<img src="/frame_19.jpg" width="300" height="200">
<img src="/frame_20.jpg" width="300" height="200">
<img src="/frame_21.jpg" width="300" height="200">
<img src="/frame_22.jpg" width="300" height="200">
<img src="/frame_23.jpg" width="300" height="200">
<img src="/frame_24.jpg" width="300" height="200">
<img src="/frame_16.jpg" width="300" height="200">
<img src="/frame_18.jpg" width="300" height="200">
<img src="/frame_4.jpg" width="300" height="200">
<img src="/frame_2.jpg" width="300" height="200">
<img src="/frame_9.jpg" width="300" height="200">
<img src="/frame_10.jpg" width="300" height="200">
<img src="/frame_17.jpg" width="300" height="200">
<img src="/frame_5.jpg" width="300" height="200">
<img src="/frame_7.jpg" width="300" height="200">
<img src="/frame_8.jpg" width="300" height="200">
<img src="/frame_20.jpg" width="300" height="200">
<img src="/frame_4.jpg" width="300" height="200">
<img src="/frame_3.jpg" width="300" height="200">
<img src="/frame_19.jpg" width="300" height="200">
<img src="/frame_8.jpg" width="300" height="200">
<img src="/frame_12.jpg" width="300" height="200">
<img src="/frame_16.jpg" width="300" height="200">
<img src="/frame_17.jpg" width="300" height="200">
<img src="/frame_23.jpg" width="300" height="200">
<img src="/frame_21.jpg" width="300" height="200">
<img src="/frame_7.jpg" width="300" height="200">
<img src="/frame_20.jpg" width="300" height="200">
<img src="/frame_2.jpg" width="300" height="200">
<img src="/frame_13.jpg" width="300" height="200">
<img src="/frame_6.jpg" width="300" height="200">
<img src="/frame_19.jpg" width="300" height="200">
<img src="/frame_9.jpg" width="300" height="200">
<img src="/frame_8.jpg" width="300" height="200">

</div>
<div id="home-text-box">
<div id="home-title">
Welcome to</br>'A Film Archive' </br>Project.
</div>
<div id="home-body">
A crowd-sourced treasure hunt.</p>
</div>
<div id="home-links">
<a href="/start/1">&#62Database</a>
<a href="/about">&#62About</a>
<a href="/contact">&#62Contact</a>
</div>
</div>
</body>
HTML
end


get '/start/:page' do

  output = ""
  output = "<html><head>"
  output += '<title>Start Page</title>' 
  output += '<link rel="stylesheet" type="text/css" href="/final.css"/>'
  output +='</head>'
  output +='<body>'
  output +='<div class="header">'
  output +='<a href="/">&#62Home</a>'
  output +='<a href="/start/1">&#62Database</a>'
  output +='<a href="/about">&#62About</a>'
  output +='<a href="/contact">&#62Contact</a>'
  output +='</div>'
  output +='<div class="start-instructions">'
  output +='<p>Click on an image to view/edit the record. Complete records appear transparent.</p>'
  offset = (params[:page].to_i - 1) * 45
  output +='</div>'
  output +='<div class="page-number-heading">'
  output +="Page #: #{params[:page]}"
  output +="</div>" 
  output +='<div class="thumbs">'
  cans = Can.all(:limit => 50, :offset => offset)
  for this in cans

    output += "<a href='/display_record/#{this.id}'"
    if(this.fullTrans=="yes")
      output += " class='completed'>"
    else
      output += ">"
    end
    output += "<img src='#{this.imageURL}' width='100' height='75'/></a>"
  end
  output +="</div>"

  output +="<div class='page-numbers'>" 
  output +="<p>go to page >   "
  (1..19).each do |i|
    if params[:page]== "#{i}"
      output +="<span class='page-number-gray'>"
      output +="<a id='this' href='/start/#{i}'>#{i}</a>"
      output +="</span>"
    elsif
    output += "<a href='/start/#{i}'>#{i}</a>"
  end
  end
  output +="</p>"
  output +="</div>"
  output += "</body></html>"
  output
  end


get '/admin' do
  output = ""
  output += "<html>"
  output += "<head><title>Admin Edit Page</title></head>"
  output += "<a href='/createRecord'> Create a New Record </a>"
  output += "</br></br>"

  cans = Can.all
  for this in cans

    output += "<a href='/edit_record/#{this.id}'>Can #{this.canNum}</a>"
    output += "</br>"
    output += "</html>"
  end
  output
end



get '/createRecord' do
  form = ''
  form +='<html><head>'
  form +='<link rel="stylesheet" type="text/css" href="/final.css"/>'
  form += '<title>Canister Database</title>' 
  form +='</head>'
  form +='<body>'
  form +='<p><h2>Admin Record Creation Form</h2></p></hr>'
  form +='<form action="/create_records" method="post">'
  form +='<p><label>Album URL</label></br> <input type="text" name="albumURL" size="80" value="-"/><p>'
  form +='<p><label>Image URL</label></br> <input type="text" name="imageURL" size="80" value="-"/><p>'
  form +='<p><label>Is this translation as complete as it can be? </label><br /><input type="radio" name="fullTrans" value="yes" /> Yes'
  form +='<br /><input type="radio" name="fullTrans" value="no" /> No</p>' 
  form +='<p><label>Can #:</label><br /> <input type="integer" name="canNum" size="3" value="000"/></p>'
  form +='<p><label>English Title:</label><br /> <input type="text" name="titleEnglish" size="55" value="-"/></p>'
  form +='<p><label>Russian Title:</label><br /> <input type="text" name="titleRussian" size="55" value="-"/></p>'
  form +='<p><label>Arabic Title:</label><br /> <input type="text" name="titleArabic" size="55" value="-"/></p>'
  form +='<p><label>Year:</label><br /> <input type="integer" name="year" size="4" value="0000"/></p>'
  form +='<p><label>Reel Number:</label><br /> <input type="integer" name="reelNumber" size="2" value="0"/>'  
  form +='<label> of:</label> <input type="integer" name="reelsTotal" size="2" value="0"/></p>'
  form +='<p><label>Country of Origin:</label><br /> <input type="text" name="country" value="-"/></p>'
  form +='<p><label>Director:</label><br /> <input type="text" name="director" size="30" value="-"/></p>'
  form +='<p>Dubbed? <br /><input type="radio" name="dubbed" value="yes"/> Yes'
  form +='<br /><input type="radio" name="dubbed" value="no" /> No</p>'
  form +='<p><label>Audio Language: </label><br /><select name="audioLang"><option>-</option><option>Arabic</option><option>English</option><option>French</option><option>Russian</option></select></p>'
  form +='<p><label>Subtitle Language 1:</label><br /><select name="subLang1"><option>None</option><option>Arabic</option><option>English</option><option>French</option><option>Russian</option></select></p>'
  form +='<p><label>Subtitle Language 2:</label><br /><select name="subLang2"><option>None</option><option>Arabic</option><option>English</option><option>French</option><option>Russian</option></select></p>'
  form +='<p><label>External Link 1:</label><br /> <input type="text" name="link1" size="80" value="-"/></p>'
  form +='<p><label>External Link 2:</label><br /> <input type="text" name="link2"size="80" value="-"/></p>'
  form +='<p><label>External Link 3:</label><br /> <input type="text" name="link3"size="80" value="-"/></p>'
  form +='<p><label>General Notes:</label><br /> <textarea name="notesGen" cols="100" rows="20"> Include your comments here. If possible, please include your name and contact info.</textarea></p>'
  form +='<p><input type="submit" value="Submit"/><p>'
  form +='</form>'
  form +='</body>'
  form +='</html>'
  form
end


post '/create_records' do
# raise params.inspect
  c = Can.new
  c.canNum = params[:canNum].to_i
  c.titleEnglish =  params[:titleEnglish].to_s
  c.titleRussian =  params[:titleRussian].to_s
  c.titleArabic =  params[:titleArabic].to_s
  c.year = params[:year].to_i
  c.reelNumber = params[:reelNumber].to_i
  c.reelsTotal =  params[:reelsTotal].to_i
  c.country =  params[:country].to_s
  c.company =  params[:company].to_s
  c.director =  params[:director].to_s
  c.audioLang =  params[:audioLang]
  c.subLang1 =  params[:subLang1]
  c.subLang2 =  params[:subLang2]
  c.dubbed =  params[:dubbed]
  c.link1 =  params[:link1].to_s
  c.link2 =  params[:link2].to_s
  c.link3 =  params[:link3].to_s
  c.notesGen =  params[:notesGen].to_s
  c.fullTrans =  params[:fullTrans]
  c.imageURL =  params[:imageURL].to_s
  c.albumURL = params[:albumURL].to_s
  c.save

output =""
output +="<p>Can # #{c.canNum} saved successfully!</p>"
output +="<a href='/createRecord'>Create Another Record</a></br>"
output +="<a href='/start/1'>Go to Start Page</a></br>"
output +="<a href='/display_record/#{c.id}'>See Record for Can # #{c.canNum}</a>"
output +="<a href='/admin'>Go to Admin List</a></br>"
output
end


get '/display_record/:id' do
  thisCan = Can.get(params[:id])

  output = ""
  output +="<html><head>"
  output +="<link rel='stylesheet' type='text/css' href='/final.css'/>"
  output += "<title>Canister Database</title>"
  output +="</head>"
  output +="<body>"
    output +="<div class='image-side'>"

  output +="<div class='header'>"
  output +='<a href="/">&#62Home</a>'
  output +='<a href="/start/1">&#62Database</a>'
  output +='<a href="/about">&#62About</a>'
  output +='<a href="/contact">&#62Contact</a>'
  output +='</div>'
  output +="<div class='can-header'>"
  output +="<div class='green-tab'>Canister #{thisCan.canNum} Record</div>"
  output +="<span class='edit-header'>"
  output +="<div id='gray-tab'><a href='/edit_record/#{thisCan.id}'>&#62Edit</a></div>"
  output +="</span>"
  output +="</div>"
  output +="<div class='large-img'>"
  output +="<p><img id='picture' src='#{thisCan.imageURL}'></p>"
    output +="<script src='/final.js'></script>"
    output +="<script src='/zoom_assets/jquery.smoothZoom.js'></script>"
    output +="<script>"
    output +="jQuery(function($){"
    output +="$('#picture').smoothZoom({"
    output +="width: 800,"
    output +="height: 600"
    output +="});"
    output +="});"
    output +="</script>"
  output +="</div>"
  output +="<div id='image-footer'>"
  output +="<p></p>"
  output +="</div>"
  output +="</div>"
  output +="<div class='form-side'>"
    output +="<p style='font-style:italic'>&#126 Scroll down for more fields &#126</p><br />"

  if thisCan.fullTrans == "yes"
  output +="<p><label style='color:red'>Has all visible info been translated? </label></br><span class='input-red'>Yes</span></p>" 
else
  output +="<p><label>Has all visible info been translated? </label></br><span class='input-red'>No</span></p>"  
end
  output +="<p><label>English Title</label></br> #{thisCan.titleEnglish}</p>"
  output +="<p><label>Russian Title</label></br> #{thisCan.titleRussian}</p>"
  output +="<p><label>Arabic Title</label></br> #{thisCan.titleArabic}</p>"
  output +="<p><label>Year</label></br> #{thisCan.year}</p>"
  output +="<p><label>Reel Number</label></br> #{thisCan.reelNumber}"
  output +=" of: #{thisCan.reelsTotal}</p>"
  output +="<p><label>Country of Origin</label></br> #{thisCan.country}</p>"
  output +="<p><label>Log/Notes (your name, date, comments): </label></br> #{thisCan.notesGen}</label></p>"
  output +="</div>"
  output +="</body>"
  output +="</html>"
  output
end


get '/edit_record/:id' do
thisEdit = Can.get(params[:id])
# output = ""
# output +="#{thisEdit.reelNumber}"
# output

form = ""
  form +="<html><head>"
  form +="<link rel='stylesheet' type='text/css' href='/final.css'/>"
  form += "<title>Canister Database</title>"
  form +="</head>"
  form +="<body>"
  form +="<div class='image-side'>"
  form +="<div class='header'>"
  form +='<a href="/">&#62Home</a>'
  form +='<a href="/start/1">&#62Database</a>'
  form +='<a href="/about">&#62About</a>'
  form +='<a href="/contact">&#62Contact</a>'
  form +='</div>'
  form +="<div class='can-header'>"
  form +="<div class='green-tab'>Edit Form - Canister #{thisEdit.canNum}</div>"
  form +="<span class='cancel-header'>"
  form +="<div id='gray-tab'><a href='/display_record/#{thisEdit.id}'>&#62Cancel</a></div>"
  form +="</span>"
  form +="</div>"
  form +="<div class='large-img'>"
  form +="<p><img id='picture' src='#{thisEdit.imageURL}'></p>"
    form +="<script src='/final.js'></script>"
    form +="<script src='/zoom_assets/jquery.smoothZoom.js'></script>"
    form +="<script>"
    form +="jQuery(function($){"
    form +="$('#picture').smoothZoom({"
    form +="width: 800,"
    form +="height: 600"
    form +="});"
    form +="});"
    form +="</script>"
  form +="</div>"
  form +="<div id='image-footer'>"
  form +="<p></p>"
  form +="</div>"
  form +="</div>"
  form +="<div class='form-side'>"
  form +="<form action='/update_record/#{thisEdit.id}' method='post'>"
  form +="<p style='font-style:italic'>&#126 Scroll down for &#34Submit&#34 button &#126</p><br />"
  form +="<p><label style='color:red'>Is this translation as complete as it can be? </label><br /><input type='radio' name='fullTrans' value='yes'/> Yes"
  form +="<br /><input type='radio' name='fullTrans' value='no' checked/> No</p>"
  form +="<p><label>English Title</label><br /> <input type='text' name='titleEnglish' size='55' value='#{thisEdit.titleEnglish}'/></p>"
  form +="<p><label>Russian Title</label><br /> <input type='text' name='titleRussian' size='55' value='#{thisEdit.titleRussian}'/></p>"
  form +="<p><label>Arabic Title</label><br /> <input type='text' name='titleArabic' size='55' value='#{thisEdit.titleArabic}'/></p>"
  form +="<p><label>Year</label><br /> <input type='integer' name='year' size='4' value='#{thisEdit.year}'/></p>"
  form +="<p><label>Reel Number</label><br /> <input type='integer' name='reelNumber' size='2' value='#{thisEdit.reelNumber}'/>"
  form +="<label> of:</label> <input type='integer' name='reelsTotal' size='2' value='#{thisEdit.reelsTotal}'/></p>"
  form +="<p><label>Country of Origin</label><br /> <input type='text' name='country' value='#{thisEdit.country}'/></p>"
  form +="<p><label>Log/Notes (your name, date, comments): </label><br /> <textarea name='notesGen' cols='60' rows='10'>#{thisEdit.notesGen}</textarea></p>"
  form +="<input type='hidden' name='imageURL' value='#{thisEdit.imageURL}'>"
  form +="<p><input class='submit-button' type='submit' value='&#62Submit'/><p>"
  form +="</form>"
  form +="</div>"
  form +="</body>"
  form +="</html>"
  form
end


post '/update_record/:id' do
thisUpdate = Can.get(params[:id])
thisUpdate.update(:titleEnglish => params[:titleEnglish].to_s)
thisUpdate.update(:titleArabic => params[:titleArabic].to_s)
thisUpdate.update(:titleRussian => params[:titleRussian].to_s)
thisUpdate.update(:year => params[:year].to_i)
thisUpdate.update(:reelNumber => params[:reelNumber].to_i)
thisUpdate.update(:reelsTotal => params[:reelsTotal].to_i)
thisUpdate.update(:country => params[:country].to_s)
thisUpdate.update(:company => params[:company].to_s)
thisUpdate.update(:director => params[:director].to_s)
thisUpdate.update(:audioLang => params[:audioLang])
thisUpdate.update(:subLang1 => params[:subLang1])
thisUpdate.update(:subLang2 => params[:subLang2])
thisUpdate.update(:dubbed => params[:dubbed])
thisUpdate.update(:link1 => params[:link1].to_s)
thisUpdate.update(:link2 => params[:link2].to_s)
thisUpdate.update(:link3 => params[:link3].to_s)
thisUpdate.update(:notesGen => params[:notesGen].to_s)
thisUpdate.update(:fullTrans => params[:fullTrans])
thisUpdate.update(:imageURL => params[:imageURL].to_s)
thisUpdate.update(:albumURL => params[:albumURL].to_s)
thisUpdate.save

output =""
output +="<html>"
  output +="<head>"
  output +="<link rel='stylesheet' type='text/css' href='/final.css'/>"
  output += "<title>Record Updated!</title>"
  output +="</head>"
  output +='<div class="header">'
  output +='<a href="/">&#62Home</a>'
  output +='<a href="/start/1">&#62Database</a>'
  output +='<a href="/about">&#62About</a>'
  output +='<a href="/contact">&#62Contact</a>'
  output +='</div>'
  output +='<div class="image-side">'
output +="<p><h2>Record updated successfully!</p></h2>"
output +="<a href='/start/1'>&#62Database</a></br>"
output +="<a href='/display_record/#{thisUpdate.id}'>&#62Can # #{thisUpdate.canNum}</a>"
output +="</div>"
output
end


get '/about' do
<<-HTML
<head>
<link rel="stylesheet" type="text/css" href="/final.css"/>
<title>About</title>
</head>
<body>
<div class="header">
<a href="/">&#62Home</a>
<a href="/start/1">&#62Database</a>
<a href="/about">&#62About</a>
<a href="/contact">&#62Contact</a>
</div>
<div class='about-header'>
<div class='green-tab'>About</div>
</div>
</div>
<div class='about-text'>
<p>
In 2009, over 850 canisters of film were discovered in Amman, Jordan. We are asking for help translating the labels of each canister so we can determine the contents of the collection.</p>
<p>Fusing cutting-edge preservation techniques with Do-It-Yourself inspired crowd-sourcing, this project aims to create a collaborative community of experts, enthusiasts and general public who believe this collection of films is of significant value to Jordan, the region, and the international community.</p>
<p>Thus far, we have only been able to digitize 10 of these reels. In this small sample, significant discoveries were made, including: </p>
<p><ul id="about-text-ul">
<li>A documentary made in 1968 titled "The Palestinian Right," directed by Mustapha Abu Ali. 
<li>Footage of His Majesty King Hussein in 1968 addressing the United Nations in the aftermath of the Six Day War.
<li>Documentary footage of Jerusalem in 1968 and its aftermath.
<li>Unidentified agit-prop films from Vietnam estimated to have been made between 1960 and 1970.
<li>Russian feature films ranging from the 1920s to the 1980s, including at least one Tarkovsky title. 
</ul></p>
<p>If we can get these labels translated, we will be in a much better position to assess the collection and plan accordingly how to proceed. Eventually, we hope to digitize as much as we can and make the films available via an interactive database.</p>
<p> We're happy you found us and hope you'll contribute by taking a few moments to explore the collection and translating anything you can. If you can't translate but still want to be involved, please <a href="/contact">contact us!</a>
</div>
<div class="about-img">
<img src="/frame_1.jpg" width="600"><br />The collection as found in Amman, Jordan in early 2010.
<p><h2>Supporters</h2><p>
<p>Temp Text</p>
</div>
</body>
HTML
end



get '/contact' do
<<-HTML
<head>
<link rel="stylesheet" type="text/css" href="/final.css"/>
<title>About</title>
</head>
<body>
<div class="header">
<a href="/">&#62Home</a>
<a href="/start/1">&#62Database</a>
<a href="/about">&#62About</a>
<a href="/contact">&#62Contact</a>
</div>
<div class='about-header'>
<div class='green-tab'>Contact</div>
</div>
<div class="contact-text">
<p>To receive updates or for general inquiries, email us at: <a href="mailto:info@filmarchive.net">info@afilmarchive.net</a></p> 
</div>
HTML
end


get '/parser' do
  username = "118319050543607777197"

albums = Picasa.albums :google_user => username # goes over the internet

albums.each do |album|
  puts
  puts "found album: #{album[:id]}"
  puts "=========================="
  puts

  a = Can.new
  
  album_string = album[:title]
  a.canType, a.canNum = album_string.split(" #") # ["Samll 16mm", "2"]
  
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
    puts "photo url: #{url}"
    
"Done!"
end
end
