require './app.rb'
# encoding: UTF-8
#require 'raramorph'

csv_header = "id, canNum, cantype, hasLanguage, title_English, title_Russian, title_Arabic, year, reelNum, reelsTotal, country, company, director, audioLang, subLang1, subLang2, dubbed, link1, link2, link3, notesGen, fullTrans, imageURL, albumURL"
	
cans = Can.all

open('./outputs/cans_csv.csv', 'w:UTF-8') { |f|
	f.puts csv_header
	cans.each do |this|
		id = "#{this[:id]}".force_encoding("UTF-8")
		canNum = "#{this[:canNum]}".force_encoding("UTF-8")
		canType = "#{this[:canType]}".force_encoding("UTF-8")
		hasLanguage = "#{this[:hasLanguage]}".force_encoding("UTF-8")
		titleEnglish = "#{this[:titleEnglish]}".force_encoding("UTF-8")
		titleRussian = "#{this[:titleRussian]}".force_encoding("UTF-8")
		titleArabic = "#{this[:titleArabic]}".force_encoding("UTF-8")
		year = "#{this[:year]}".force_encoding("UTF-8")
		reelNumber = "#{this[:reelNumber]}".force_encoding("UTF-8")
		reelsTotal = "#{this[:reelsTotal]}".force_encoding("UTF-8")
		country = "#{this[:country]}".force_encoding("UTF-8")
		company = "#{this[:company]}".force_encoding("UTF-8")
		director = "#{this[:director]}".force_encoding("UTF-8")
		audioLang = "#{this[:audioLang]}".force_encoding("UTF-8")
		subLang1 = "#{this[:subLang1]}".force_encoding("UTF-8")
		subLang2 = "#{this[:subLang2]}".force_encoding("UTF-8")
		dubbed = "#{this[:dubbed]}".force_encoding("UTF-8")
		link1 = "#{this[:link1]}".force_encoding("UTF-8")
		link2 = "#{this[:link2]}".force_encoding("UTF-8")
		link3 = "#{this[:link3]}".force_encoding("UTF-8")
		notesGen = "#{this[:notesGen]}".force_encoding("UTF-8")
		fullTrans = "#{this[:fullTrans]}".force_encoding("UTF-8")
		imageURL = "#{this[:imageURL]}".force_encoding("UTF-8")
		albumURL = "#{this[:albumURL]}".force_encoding("UTF-8")

		finalString = id << "," << canNum << "," << canType << "," << hasLanguage << "," << titleEnglish << "," << titleRussian << "," << titleArabic << "," << year << "," << reelNumber << "," << reelsTotal << "," << country << "," << company << "," << director << "," << audioLang << "," << subLang1 << "," << subLang2 << "," << dubbed << "," << link1 << "," << link2 << "," << link3 << "," << notesGen << "," << fullTrans << "," << imageURL << "," << albumURL
        finalString.force_encoding("UTF-8")
		f.puts finalString

  	end
}

#Raramorph.execute("cans_csv.csv", "cans_trans_csv.csv", not_arabic=true, )



	
