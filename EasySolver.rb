require 'net/http'
require 'uri'
require 'colorize'


$host = 'localhost'
$path = '/index.php'
$port = 80
$keyword = 'CTF'

ARGV.each do |arg|
    $host = arg.split("=")[1] if arg.include?("--host=")
    $path = arg.split("=")[1] if arg.include?("--path=")
    $port = arg.split("=")[1] if arg.include?("--port=")
    $keyword = arg.split("=")[1] if arg.include?("--key=")
end

res = Net::HTTP.get_response($host, $path, $port)

puts "===========header===========".colorize(:blue)
URI.unescape(res.to_hash.to_s).scan(/#{$keyword}{([^}]*)}/) {|str| puts "#{$keyword}{#{str[0].to_s}}".colorize(:green)}
puts "============================".colorize(:blue)

puts "\n"

puts "============body============".colorize(:blue)
URI.unescape(res.body).scan(/#{$keyword}{([^}]*)}/) {|str| puts "#{$keyword}{#{str[0].to_s}}".colorize(:green)}
puts "============================".colorize(:blue)

puts "\n"

# robots.txt
res2 = Net::HTTP.get_response($host, '/robots.txt', $port)
if res2.code == '200'
    puts "=========robots.txt=========".colorize(:blue)
    puts res2.body
    puts "============================".colorize(:blue)
end

puts "\n"

# .DS_Store
res2 = Net::HTTP.get_response($host, '/.DS_Store', $port)
if res2.code == '200'
    puts "==========.DS_Store=========".colorize(:blue)
    puts ".DS_Store Found!".colorize(:yellow)
    puts "============================".colorize(:blue)
end

puts "\n"


# .git/
res2 = Net::HTTP.get_response($host, '/.git/', $port)
if res2.code != '404'
    puts "=============git============".colorize(:blue)
    puts ".git/ Found!".colorize(:yellow)
    puts "============================".colorize(:blue)
end

puts "\n"

# .svn/
res2 = Net::HTTP.get_response($host, '/.svn/', $port)
if res2.code != '404'
    puts "=============svn============".colorize(:blue)
    puts ".svn/ Found!".colorize(:yellow)
    puts "============================".colorize(:blue)
end


puts "\n"

# WEB-INF/
res2 = Net::HTTP.get_response($host, '/WEB-INF/', $port)
if res2.code != '404'
    puts "===========WEB-INF==========".colorize(:blue)
    puts "WEB-INF/ Found!".colorize(:yellow)
    puts "============================".colorize(:blue)
end

puts "\n"

# admin/
res2 = Net::HTTP.get_response($host, '/admin/', $port)
if res2.code != '404'
    puts "=============git============".colorize(:blue)
    puts "admin/ Found!".colorize(:yellow)
    puts "============================".colorize(:blue)
end

puts "\n"

# login/
res2 = Net::HTTP.get_response($host, '/login/', $port)
if res2.code != '404'
    puts "============login===========".colorize(:blue)
    puts "login/ Found!".colorize(:yellow)
    puts "============================".colorize(:blue)
end

puts "\n"

# phpMyAdmin/ phpmyadmin/ pma/
res2 = Net::HTTP.get_response($host, '/phpMyAdmin/', $port)
if res2.code != '404'
    puts "==========phpMyAdmin========".colorize(:blue)
    puts "phpMyAdmin/ Found!".colorize(:yellow)
    puts "============================".colorize(:blue)
end

res2 = Net::HTTP.get_response($host, '/phpmyadmin/', $port)
if res2.code != '404'
    puts "==========phpmyadmin========".colorize(:blue)
    puts "phpmyadmin/ Found!".colorize(:yellow)
    puts "============================".colorize(:blue)
end

res2 = Net::HTTP.get_response($host, '/pma/', $port)
if res2.code != '404'
    puts "=============pma============".colorize(:blue)
    puts "pma/ Found!".colorize(:yellow)
    puts "============================".colorize(:blue)
end

puts "\n"



URI.unescape(res.body).scan(/\"([^\"]*).js\"/) do |str| 
    puts "#{str[0].to_s}.js Found!".colorize(:yellow)
    tmp_res = Net::HTTP.get_response($host, "/#{str[0].to_s}.js", $port)
    URI.unescape(tmp_res.body).scan(/#{$keyword}{([^}]*)}/) {|str| puts "#{$keyword}{#{str[0].to_s}}".colorize(:green)}
end

URI.unescape(res.body).scan(/\"([^\"]*).css\"/) do |str| 
    puts "#{str[0].to_s}.css Found!".colorize(:yellow)
    tmp_res = Net::HTTP.get_response($host, "/#{str[0].to_s}.css", $port)
    URI.unescape(tmp_res.body).scan(/#{$keyword}{([^}]*)}/) {|str| puts "#{$keyword}{#{str[0].to_s}}".colorize(:green)}
end
