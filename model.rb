DataMapper::setup(:default, ENV['DATABASE_URL'] || "sqlite:///Users/matthewepler/Documents/RFC film Project Summary/Website Files Archive/final/data.db")

class Can
  include DataMapper::Resource

  property :id, Serial
  property :canNum, Integer
  property :canType, String
  property :hasLanguage, String
  property :hasArabic, String
  property :hasRussian, String
  property :titleEnglish, String
  property :titleRussian, String
  property :titleArabic, String
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
