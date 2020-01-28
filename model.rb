DataMapper::setup(:default, ENV['DATABASE_URL'] || "sqlite:///mnt/c/Users/Lenovo/Documents/dev/aarchive/data.db?encoding=UTF8")
class Can
  include DataMapper::Resource

  property :id, Serial
  property :canNum, Integer
  property :canType, String
  property :hasLanguage, String
  property :titleEnglish, Text
  property :titleRussian, Text
  property :titleArabic, Text
  property :year, Integer
  property :reelNumber, Integer
  property :reelsTotal, Integer
  property :country, String
  property :company, String
  property :director, String
  property :audioLang, String
  property :subLang1, String
  property :subLang2, String
  property :dubbed, String
  property :link1, String
  property :link2, String
  property :link3, String
  property :notesGen, String
  property :fullTrans, String
  property :imageURL, Text
  property :albumURL, Text
end

DataMapper.finalize
