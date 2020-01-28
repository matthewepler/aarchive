# About
Site is deployed via Heroku with heroku postgres db  

#To get running locally  
bundle install  
run server (bundle exec rackup -p 3000)
Try the "Database" link
If unable to connect, change the sqlite string at top of model.rb to your local model.db file  

Automatic backups are enabled by default on Heroku  

# Backups  
To backup database manually, connect using pgAdmin or similar  
and Export the desired file type.  

#Helpful links  
Ruby install packages: https://www.brightbox.com/docs/ruby/ubuntu/
