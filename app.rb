require 'bundler'
Bundler.require
require 'bundler/setup'
require 'rubygems'
require './model.rb'
# set :protection, :except => :frame_options

get '/' do
  <<-HTML
<link rel="stylesheet" type="text/css" href="/final.css"/>
<head>
  <!-- Google Analytics -->
  <script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-30138184-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
</head>
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
<!-- <div class="facebook"
<iframe src="http://www.facebook.com/plugins/like.php?href=http://afilmarchive.net"
        scrolling="no" frameborder="0"
        style="border:none; width:450px; height:80px"></iframe>
      </div> -->
</div>
</body>
HTML
end


get '/start/:page' do

  output = ""
  output = "<html><head>"
  output += '<title>Start Page</title>' 
  output += '<link rel="stylesheet" type="text/css" href="/final.css"/>'
  <<-HTML
   <!-- Google Analytics -->
  <script type="text/javascript">

  'var _gaq = _gaq || [];
  '_gaq.push(['_setAccount', 'UA-30138184-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
HTML
  output +='</head>'
  output +='<body>'
  output +='<div class="header">'
  output +='<a href="/">&#62Home</a>'
  output +='<a href="/start/1">&#62Database</a>'
  output +='<a href="/about">&#62About</a>'
  output +='<a href="/contact">&#62Contact</a>'
  output +='<span class="search-link"><a href="/search">&#62Search</a></span>'
  output +='<a style="color: red" href="http://itp.nyu.edu/~mae383/aFilmArchive_HowTo.mov">&#62How to use this database (video)</a>'
  output +='</div>'
  output +='<div class="start-instructions">'
  output +='<p>Click on an image to view/edit the record. Complete records appear transparent.'
  offset = (params[:page].to_i - 1) * 45
  output +='</div>'
  output +='<div class="page-number-heading">'
  output +="Page #: #{params[:page]}"
  output +='<span class="translated-counter">'
  all_count = Can.all(:fullTrans => "yes")
  full_count = all_count.count
  output +="<p>#{full_count}&#32 of 850 records translated!</p>"
  output +="</span>"
  output +="</div>" 
  output +='<div class="thumbs">'
  cans = Can.all(:limit => 50, :offset => offset)
  #for each can
  for this in cans
    link_name = " "
    name_array = Dir.entries('thumbimages')

    #go through the name array and find the matching filename
    for name_string in name_array
      if name_string.include? this.canNum.to_s && this.canType
        link_name = name_string
        break
      else
        link_name = link_name
      end
    end

    output += "<a href='/display_record/#{this.id}'"
    
    if(this.fullTrans=="yes")
      output += " class='completed'>"
    else
      output += ">"
    end

    output += "<img src='thumbimages/#{link_name}' width='100' height='75'/></a>"
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
    # output +="<p><a href='/list'>List View</a></p>"

    output += "<div class='input-red'><p>Note: 35mm Canisters 1-120 have close-ups of the actual film stock. They can be found<span><a href ='https://picasaweb.google.com/118319050543607777197?showall=true'>&#32HERE</a></p></span>"
  output +="</div>"

  output += "</body></html>"
  output
  end


get '/list' do
  output = ""
  output += "<html>"
  output += "<head><title>List View</title></head>"
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
  form +='<p><label>General Notes:</label><br /> <textarea name="notesGen" cols="100" rows="20" wrap="hard"> Include your comments here. If possible, please include your name and contact info.</textarea></p>'
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
  c.hasLanguage = params[:hasLanguage].to_s
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
    <<-HTML
   <!-- Google Analytics -->
  <script type="text/javascript">

  'var _gaq = _gaq || [];
  '_gaq.push(['_setAccount', 'UA-30138184-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
HTML
  output +="</head>"
  output +="<body>"
    output +="<div class='image-side'>"

  output +="<div class='header'>"
  output +='<a href="/">&#62Home</a>'
  output +='<a href="/start/1">&#62Database</a>'
  output +='<a href="/about">&#62About</a>'
  output +='<a href="/contact">&#62Contact</a>'
  output +='<span class="search-link"><a href="/search">&#62Search</a></span>'
  output +='<a style="position:relative;left:350" href="/display_record/'
  prevpage = (params[:id].to_i - 1)
  output += "#{prevpage}"
  output += '">Prev&#60</a>'
  output +='<a style="text-align:right;position:relative;left:530" href="/display_record/'
  nextpage =  (params[:id].to_i + 1)
  output += "#{nextpage}"
  output += '">&#62Next</a>'
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
  output +="<p>CAN SIZE, FILM GAUGE:&#32 #{thisCan.canType}</p>"
  output +="</div>"
  output +="<div id='image-footer'>"
  output +="<p></p>"
  output +="</div>"

  output +='<div id="HCB_comment_box"><a href="http://www.htmlcommentbox.com">HTML Comment Box</a> is loading comments...</div>'
  output +='<link rel="stylesheet" type="text/css" href="http://www.htmlcommentbox.com/static/skins/simple/skin.css" />'
 output +='<script type="text/javascript" language="javascript" id="hcb"> /*<!--*/ if(!window.hcb_user){hcb_user={  };} (function(){s=document.createElement("script");s.setAttribute("type","text/javascript");s.setAttribute("src", "http://www.htmlcommentbox.com/jread?page="+escape((window.hcb_user && hcb_user.PAGE)||(""+window.location)).replace("+","%2B")+"&opts=470&num=10");if (typeof s!="undefined") document.getElementsByTagName("head")[0].appendChild(s);})(); /*-->*/ </script>'
  
  output +="</div>"
  output +="<div class='form-side'>"
    output +="<p style='font-style:italic'>&#126 Scroll down for more fields &#126</p><br />"

  if thisCan.fullTrans == "yes"
  output +="<p><label style='color:red'>Has all visible info been translated? </label></br><span class='input-red'>Yes</span></p>" 
else
  output +="<p><label>Has all visible info been translated? </label></br><span class='input-red'>No</span></p>"  
end
  # output +="<p><label>Languages to be Translated</label></br> #{thisCan.hasLanguage}</p>"
  # output +="<p><label>Album URL</label></br> #{thisCan.albumURL}</p>"
  output +="<p><label>English Title</label></br> #{thisCan.titleEnglish}</p>"
  output +="<p><label>Russian Title</label></br> #{thisCan.titleRussian}</p>"
  output +="<p><label>Arabic Title</label></br> #{thisCan.titleArabic}</p>"
  output +="<p><label>Company</label></br> #{thisCan.company}</p>"
  output +="<p><label>Year</label></br> #{thisCan.year}</p>"
  output +="<p><label>Reel Number</label></br> #{thisCan.reelNumber}"
  output +=" of: #{thisCan.reelsTotal}</p>"
  output +="<p><label>Admin Notes: </label></br> #{thisCan.notesGen}</label></p>"
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
    <<-HTML
   <!-- Google Analytics -->
  <script type="text/javascript">

  'var _gaq = _gaq || [];
  '_gaq.push(['_setAccount', 'UA-30138184-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
HTML
  form +="</head>"
  form +="<body>"
  form +="<div class='image-side'>"
  form +="<div class='header'>"
  form +='<a href="/">&#62Home</a>'
  form +='<a href="/start/1">&#62Database</a>'
  form +='<a href="/about">&#62About</a>'
  form +='<a href="/contact">&#62Contact</a>'
  form +='<span class="search-link"><a href="/search">&#62Search</a></span>'
  form +='<a style="position:relative;left:350" href="/display_record/'
  prevpage = (params[:id].to_i - 1)
  form += "#{prevpage}"
  form += '">Prev&#60</a>'
  form +='<a style="text-align:right;position:relative;left:600" href="/display_record/'
  nextpage =  (params[:id].to_i + 1)
  form += "#{nextpage}"
  form += '">&#62Next</a>'
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
  form +="<p>CAN SIZE, FILM GAUGE:&#32 #{thisEdit.canType}</p>"
  form +="</div>"
  form +="<div id='image-footer'>"
  form +="<p>&#126 To add a comment, return to the display page for this record &#126</p>"
  form +="</div>"
  form +="</div>"
  form +="<div class='form-side'>"
  form +="<form action='/update_record/#{thisEdit.id}' method='post'>"
  form +="<p style='font-style:italic'>&#126 Scroll down for &#34Submit&#34 button &#126</p><br />"
  # form +="<p><label>Languages to be Translated</label><br />"
  # form +="<input type = 'checkbox' name='hasarabic' value='arabic' /> Arabic<br />"
  # form +="<input type = 'checkbox' name='hasrussian' value='russian' /> Russian<br />"
  form +="<p><label>English Title</label><br /> <input type='text' name='titleEnglish' size='50' value='#{thisEdit.titleEnglish}'/></p>"
  form +="<p><label>Russian Title</label><br /> <input type='text' name='titleRussian' size='50' value='#{thisEdit.titleRussian}'/></p>"
  form +="<p><label>Arabic Title</label><br /> <input type='text' name='titleArabic' size='50' value='#{thisEdit.titleArabic}'/></p>"
  form +="<p><label>Company</label><br /> <input type='text' name='company' size='50' value='#{thisEdit.company}'/></p>"
  form +="<p><label>Year</label><br /> <input type='integer' name='year' size='4' value='#{thisEdit.year}'/></p>"
  form +="<p><label>Reel Number</label><br /> <input type='integer' name='reelNumber' size='2' value='#{thisEdit.reelNumber}'/>"
  form +="<label> of:</label> <input type='integer' name='reelsTotal' size='2' value='#{thisEdit.reelsTotal}'/></p>"
  # form +="<p><label>Admin Notes: </label><br /> <textarea name='notesGen' cols='40' rows='10' wrap='hard'>#{thisEdit.notesGen}</textarea></p>"
  form +="<p><label>Admin Notes: </label></br> #{thisEdit.notesGen}</label></p><br />"
  form +="<p><label style='color:red'>Is this translation as complete as it can be? </label><br /><input type='radio' name='fullTrans' value='yes'/> Yes"
  form +="<br /><input type='radio' name='fullTrans' value='no' checked/> No</p>"
  form +="<input type='hidden' name='imageURL' value='#{thisEdit.imageURL}'>"
  form +="<input type='hidden' name='canType' value='#{thisEdit.canType}'>"
  form +="<input type='hidden' name='hasLanguage' value='#{thisEdit.hasLanguage}'>"
  form +="<p><input class='submit-button' type='submit' value='&#62Submit'/><p>"
  form +="</form>"
  form +="</div>"
  form +="</body>"
  form +="</html>"
  form
end


post '/update_record/:id' do
thisUpdate = Can.get(params[:id])
# language = 'string'
# if !params[:hasarabic].nil? 
#   language = 'arabic'
#   arabic = params[:hasarabic]
#   if !params[:hasrussian].nil?
#     russian = params[:hasrussian]
#     language = arabic + "," + russian
#   end
# elsif
# if !params[:hasrussian].nil?
#   language = 'russian'
#   russian = params[:hasrussian]
#   if !params[:hasarabic].nil?
#     arabic = params[:hasarabic]
#     language = arabic + "," + russian
#   end
# end
# end

thisUpdate.update(:hasLanguage => params[:hasLanguage].to_s)
thisUpdate.update(:titleEnglish => params[:titleEnglish])
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
thisUpdate.update(:fullTrans => params[:fullTrans].to_s)
thisUpdate.update(:imageURL => params[:imageURL].to_s)
thisUpdate.update(:albumURL => params[:albumURL].to_s)
thisUpdate.update(:canType => params[:canType].to_s)
thisUpdate.save

output = ""
output +="<html>"
  output +="<head>"
  output +="<link rel='stylesheet' type='text/css' href='/final.css'/>"
  output += "<title>Record Updated!</title>"
    <<-HTML
   <!-- Google Analytics -->
  <script type="text/javascript">

  'var _gaq = _gaq || [];
  '_gaq.push(['_setAccount', 'UA-30138184-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
HTML
  output +="</head>"
  output +='<div class="header">'
  output +='<a href="/">&#62Home</a>'
  output +='<a href="/start/1">&#62Database</a>'
  output +='<a href="/about">&#62About</a>'
  output +='<a href="/contact">&#62Contact</a>'
  output +='<span class="search-link"><a href="/search">&#62Search</a></span>'
  output +='</div>'
  output +='<div class="image-side">'
  output +="<p><h2>Record updated successfully!</p></h2>"
  output +="<a href='/display_record/#{thisUpdate.id}'>&#62Review Your Changes</a></br>"
output +="<a href='/display_record/"
  nextpage = (params[:id].to_i + 1)
  output += "#{nextpage}'"
  output += ">&#62View Next Record</a></br>"
  output +="<a href='/start/1'>&#62Return to Database</a></br>"

output +="</div>"
output
end


get '/about' do
<<-HTML
<head>
<link rel="stylesheet" type="text/css" href="/final.css"/>
<title>About</title>
   <!-- Google Analytics -->
  <script type="text/javascript">

  'var _gaq = _gaq || [];
  '_gaq.push(['_setAccount', 'UA-30138184-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>

</head>
<body>
<div class="header">
<a href="/">&#62Home</a>
<a href="/start/1">&#62Database</a>
<a href="/about">&#62About</a>
<a href="/contact">&#62Contact</a>
<span class="search-link"><a href="/search">&#62Search</a></span>

</div>
<div class='about-header'>
<div class='green-tab'>About</div>
</div>
</div>

<!-- about_text.rtf -->
<div>
<h2 style="margin-left:170px">This is DIY archiving</h2>
<p style="margin-left:90px"><i>A truly collaborative project with no ownership by any one person or institution.</i></p>
</div>
<div class='about-text'>
<p>
In 2009, over 850 canisters of film were discovered in Amman, Jordan. We are asking for help translating the labels of each canister so we can determine the contents of the collection.</p>
<p>Fusing cutting-edge preservation techniques with Do-It-Yourself inspired crowd-sourcing, this project aims to create a collaborative community of experts, enthusiasts and general public who believe this collection of films is of significant value to Jordan, the region, and the international community. 
</p>
<p>Thus far, we have only been able to digitize 10 of these reels. In this small sample, significant discoveries were made, including: </p>
<p><ul id="about-text-ul">
<li>A documentary confirmed to be part of the PLO film archive, lost in 1985.
<li>Footage of HM King Hussein in 1968 addressing the United Nations in the aftermath of the Six Day War.
<li>Documentary footage of Jerusalem in 1968 and its aftermath.
<li>Unidentified propaganda films from Vietnam made to highlight relations between Vietnam, Russia, and political struggles in the Middle East in the 1960s and 70s.
<li>Russian feature films sent as part of a cultural exchange between Russian and Arab partners, ranging from the 1920s to the 1980s. </ul></p>
<p>If we can get these labels translated, we will be in a much better position to assess the collection and plan accordingly how to proceed. Eventually, we hope to digitize as much as we can and make the films available via an interactive database.</p>
<p> We are happy you found us and hope you will contribute by taking a few moments to explore the collection and translating anything you can. If you cannot translate but still want to be involved, please <a href="http://itp.nyu.edu/~mae383/sinatra/final/contact">contact us!</a>
</div>


<div class="about-img">
<img src="/frame_1.jpg" width="600"><br />The collection as found in Amman, Jordan in early 2010.
<p><h2>Press</h2></p>
<p><a href="http://english.al-akhbar.com/content/unearthing-jordan%E2%80%99s-soviet-cinema">Al-Alkhbar English: "Unearthing Jordan's Soviet Cinema"</a></p>
<p><a href="http://www.facebook.com/afilmarchive">&#62Add us on Facebook</a>
<p><a href="https://twitter.com/#!/aFilmArchiveNet">&#62Follow us on Twitter</a>
</div>
</body>
HTML
end



get '/contact' do
<<-HTML
<head>
<link rel="stylesheet" type="text/css" href="/final.css"/>
<title>About</title>
   <!-- Google Analytics -->
  <script type="text/javascript">

  'var _gaq = _gaq || [];
  '_gaq.push(['_setAccount', 'UA-30138184-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>

</head>
<body>
<div class="header">
<a href="/">&#62Home</a>
<a href="/start/1">&#62Database</a>
<a href="/about">&#62About</a>
<a href="/contact">&#62Contact</a>
<span class="search-link"><a href="/search">&#62Search</a></span>

</div>
<div class='about-header'>
<div class='green-tab'>Contact</div>
</div>
<div class="contact-text">
<p>To receive updates or for general inquiries, email us at: <a href="mailto:info@filmarchive.net">info@afilmarchive.net</a></p> 
</div>
HTML
end

get '/search' do
 form = ""
  form +="<html><head>"
  form +="<link rel='stylesheet' type='text/css' href='/final.css'/>"
  form += "<title>Search</title>"
    <<-HTML
   <!-- Google Analytics -->
  <script type="text/javascript">

  'var _gaq = _gaq || [];
  '_gaq.push(['_setAccount', 'UA-30138184-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
HTML
  form +="</head>"
  form +="<body>"
  form +="<div class='image-side'>"
  form +="<div class='header'>"
  form +='<a href="/">&#62Home</a>'
  form +='<a href="/start/1">&#62Database</a>'
  form +='<a href="/about">&#62About</a>'
  form +='<a href="/contact">&#62Contact</a>'
  form +='<span class="search-link"><a href="/search">&#62Search</a></span>'
  form +='</div>'
  form +='<div class="search-header">'
  form +='<div class="green-tab">Search</div>'
  form +='</div>'
  form +='</div>'
  form +='<div class = "search-area">'
  form +='<form action="/displaysearch" method="get">'
  form +='<p><label>Search is restricted to one category only</label></p>'
  form +='<p><label>You must clear all text fields and set drop-downs to "None" before beginning a new search.</label></p> '
  form +='<p>Language   '
  form +='<select name="hasLanguage"><option value="none">None</option><option value="arabic">Arabic</option><option value="russian">Russian</option><option value="both">Both</option></select>'
  form +='<input class="search-go" type="submit" value="&#62go"/><p>'
  form +='<p><label>OR</label></p>'
  form +='<p>Fully Translated?   '
  form +='<select name="fullTrans"><option value="none">None</option><option value = "yes">Yes</option><option value="no">No</option></select>'
  form +='<input class="search-go" type="submit" value="&#62go"/><p>'
  form +='<p><label>OR</label></p>'
  form +='<p>Canister Number   '
  form +='<input type="text" name="canNum" size="4" />'
  form +='<input class="search-go" type="submit" value="&#62go"/><p>'
  form +='<p><label>OR</label></p>'
  form +='<p>Title (English)   '
  form +='<input type="text" name="titleEnglish" size="14" />'
  form +='<input class="search-go" type="submit" value="&#62go"/><p>'
  form +='</form>'
  form +='</div>'
  form +='</div>'
  form +='</body>'
  form +='</html>'
  form
end

get '/displaysearch' do
  output = ""
  output +="<html><head>"
  output +="<link rel='stylesheet' type='text/css' href='/final.css'/>"
  output += "<title>Results</title>"
    <<-HTML
   <!-- Google Analytics -->
  <script type="text/javascript">

  'var _gaq = _gaq || [];
  '_gaq.push(['_setAccount', 'UA-30138184-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
HTML
  output +="</head>"
  output +="<body>"
  output +="<div class='image-side'>"
  output +="<div class='header'>"
  output +='<a href="/">&#62Home</a>'
  output +='<a href="/start/1">&#62Database</a>'
  output +='<a href="/about">&#62About</a>'
  output +='<a href="/contact">&#62Contact</a>'
  output +='<span class="search-link"><a href="/search">&#62Search</a></span>'
  output +='</div>'
  output +='<div class="search-header">'
  output +='<div class="green-tab">Results</div>'
  output +='</div>'
  output +='</div>'
  output +='</div>'
  output +='<div class = "search-area">'
  output +='<p>&#126 Completed records will appear transparent &#126</p>'

  cans = nil
  if params[:hasLanguage] != "none"
    @cans = Can.all(:hasLanguage => params[:hasLanguage])
    output +="<p>#{@cans.count} records found</p>"
    @cans.each do |this|
    # incoming = params[:hasLanguage]
    # cans = Can.all
    # for this in cans
    #   current = this.hasLanguage
    #   if !current.nil?
    #     if current.include? incoming 
            output +="<a href='/display_record/#{this.id}'"
              if(this.fullTrans=="yes")
                output += " id='completed'>"
              else
                output += ">"
              end
            output +="<img src='#{this.imageURL}' width='100' height='75 /></a>" 
            output +="<a href='display_record/#{this.id}'>&#62 Can #{this.canNum}</a>&#32 (#{this.canType})</p>"
        # end
      # end
    end
  
  elsif params[:fullTrans] != "none"
    @cans = Can.all(:fullTrans => params[:fullTrans])
    output +="<p>#{@cans.count} records found</p>"
    @cans.each do |can|
      output +="<a href='/display_record/#{can.id}'"
      if(can.fullTrans=="yes")
        output += " id='completed'>"
      else
       output += ">"
      end
      output +="<img src='#{can.imageURL}' width='100' height='75 /></a>"
      output +="<p><a href='display_record/#{can.id}'>&#62 Can #{can.canNum}</a>&#32 (#{can.canType})</p>"
    end

  elsif params[:canNum] != ""
    @cans = Can.all(:canNum => params[:canNum])
    output +="<p>#{@cans.count} records found</p>"
    @cans.each do |can|
      output +="<a href='/display_record/#{can.id}'"
      if(can.fullTrans=="yes")
        output += " id='completed'>"
      else
        output += ">"
      end
      output +="<img src='#{can.imageURL}' width='100' height='75 /></a>"
      output +="<p><a href='display_record/#{can.id}'>&#62 Can #{can.canNum}</a>&#32 (#{can.canType})</p>"   
    end 

  elsif params[:titleEnglish] != ""
    incoming = params[:titleEnglish]
    cans = Can.all
    for can in cans
      title = can.titleEnglish
      if !title.nil?
        if title.include? incoming
    # output +="<p>#{@cans.count} records found</p>"
      # if !can.titleEnglish.nil?
      #   title = can.titleEnglish
      #   search = params[:titleEnglish].to_s
      #   if title.include? params[:titleEnglish]
          output +="<a href='/display_record/#{can.id}'"
          if(can.fullTrans=="yes")
            output += " id='completed'>"
          else
             output += ">"
          end
          output +="<img src='#{can.imageURL}' width='100' height='75 /></a>"
          output +="<p><a href='display_record/#{can.id}'>&#62 Can #{can.canNum}</a>&#32 (#{can.canType})</p>"   
       end
     end
    end 
    
  end
  output +="</div>"   
  output
end

  



get '/parser' do
  username = "118319050543607777197"

albums = Picasa.albums :google_user => username # goes over the internet
counter = 1

albums.each do |album|
  puts counter
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
    counter = counter + 1
    
end
puts "Done!"
end

# THIS IS BEYOND ALL CRAZINESS IN THE WORLD!!!!
# WE PUT IN 'TYPE' BEFORE NAME TO FIX dm-migrations PG PROBLEM
require 'dm-migrations/migration_runner'

get "/migrate" do
  migration 2, :change_language_type do
    up do
      modify_table :cans do
        change_column 'title_arabic', 'TYPE text'
        change_column 'title_russian', 'TYPE text'
      end
    end
  end
  migrate_up!
  "Done!"
end
