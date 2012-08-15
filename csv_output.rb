require './app.rb'

csv_header = "id, canNum, cantype, hasLanguage, title_English, title_Russian, title_Arabic, year, reelNum, reelsTotal, country, company, director, audioLang, subLang1, subLang2, dubbed, link1, link2, link3, notesGen, fullTrans, imageURL, albumURL"
	
cans = Can.all

open('./outputs/cans_csv.csv', 'w:UTF-8') { |f|
	f.puts csv_header
	cans.each do |this|
		id = "#{this[:id]}"
		canNum = "#{this[:canNum]}"
		canType = "#{this[:canType]}"
		hasLanguage = "#{this[:hasLanguage]}"
		titleEnglish = "#{this[:titleEnglish]}"
		titleRussian = "#{this[:titleRussian]}"
		titleArabic = "#{this[:titleArabic]}"
		year = "#{this[:year]}"
		reelNumber = "#{this[:reelNumber]}"
		reelsTotal = "#{this[:reelsTotal]}"
		country = "#{this[:country]}"
		company = "#{this[:company]}"
		director = "#{this[:director]}"
		audioLang = "#{this[:audioLang]}"
		subLang1 = "#{this[:subLang1]}"
		subLang2 = "#{this[:subLang2]}"
		dubbed = "#{this[:dubbed]}"
		link1 = "#{this[:link1]}"
		link2 = "#{this[:link2]}"
		link3 = "#{this[:link3]}"
		notesGen = "#{this[:notesGen]}"
		fullTrans = "#{this[:fullTrans]}"
		imageURL = "#{this[:imageURL]}"
		albumURL = "#{this[:albumURL]}" 

		finalString = id << "," << canNum << "," << canType << "," << hasLanguage << "," << titleEnglish << "," << titleRussian << "," << titleArabic << "," << year << "," << reelNumber << "," << reelsTotal << "," << country << "," << company << "," << director << "," << audioLang << "," << subLang1 << "," << subLang2 << "," << dubbed << "," << link1 << "," << link2 << "," << link3 << "," << notesGen << "," << fullTrans << "," << imageURL << "," << albumURL

		f.puts finalString

  	end
}




	
