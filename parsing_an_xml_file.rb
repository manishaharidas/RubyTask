require 'rexml/document'
require 'mysql'
include REXML

mysql = Mysql.new("localhost", "root", "", "diasdb") # connection to mysql database "diasdb"
xmlfile = File.new("sitemap.xml")
xmldoc = Document.new(xmlfile) # converting the xmlfile into document
puts("the given xml file is parsed and the result is ")
puts(xmldoc)   #the parsed xml file is displayed.

mysql.query("create table if not exists urlset(id int auto_increment primary key,location varchar(70),priority varchar(10))")
# for each element in */url in the xml file
xmldoc.elements.each("urlset/url") do |e|  
	@loc=e.elements["loc"].text.to_s 
	@priority=e.elements["priority"].text.to_s
	# inserting into table urlset 
	mysql.query("insert into urlset (location,priority)values('#{@loc}','#{@priority}')")
end
# displaying the table urlset from database
puts "Location and Priority are added to mysql table \"urlset\""
puts "Location       Priority"
result = mysql.query("select * from urlset ")
result.each_hash do |i|
    puts "#{i['location']}    #{i['priority']}"
end	



	



