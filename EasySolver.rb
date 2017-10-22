require 'net/http'
require 'uri'
require 'colorize'


$host = 'localhost'
$path = '/index.php'
$keyword = 'CTF'

ARGV.each do |arg|
    $host = arg.split("=")[1] if arg.include?("--host=")
    $path = arg.split("=")[1] if arg.include?("--path=")
    $keyword = arg.split("=")[1] if arg.include?("--key=")
end

res = Net::HTTP.get_response($host, $path)

puts "===========header===========".colorize(:blue)
URI.unescape(res.to_hash.to_s).scan(/#{$keyword}{([^}]*)}/) {|str| puts "#{$keyword}{#{str[0].to_s}}".colorize(:green)}
puts "============================".colorize(:blue)

puts "\n"

puts "============body============".colorize(:blue)
URI.unescape(res.body).scan(/#{$keyword}{([^}]*)}/) {|str| puts "#{$keyword}{#{str[0].to_s}}".colorize(:green)}
puts "============================".colorize(:blue)

puts "\n"

res2 = Net::HTTP.get_response($host, '/robots.txt')
if res2.code == '200'
    puts "=========robots.txt=========".colorize(:blue)
    puts res2.body
    puts "============================".colorize(:blue)
end

puts "\n"

res2 = Net::HTTP.get_response($host, '/.git/')
if res2.code != '404'
    puts "=============git============".colorize(:blue)
    puts ".git Found!".colorize(:yellow)
    puts "============================".colorize(:blue)
end

puts "\n"


URI.unescape(res.body).scan(/\"([^\"]*).js\"/) do |str| 
    puts "#{str[0].to_s}.js Found!".colorize(:yellow)
    tmp_res = Net::HTTP.get_response($host, "/#{str[0].to_s}.js")
    URI.unescape(tmp_res.body).scan(/#{$keyword}{([^}]*)}/) {|str| puts "#{$keyword}{#{str[0].to_s}}".colorize(:green)}
end

URI.unescape(res.body).scan(/\"([^\"]*).css\"/) do |str| 
    puts "#{str[0].to_s}.css Found!".colorize(:yellow)
    tmp_res = Net::HTTP.get_response($host, "/#{str[0].to_s}.css")
    URI.unescape(tmp_res.body).scan(/#{$keyword}{([^}]*)}/) {|str| puts "#{$keyword}{#{str[0].to_s}}".colorize(:green)}
end
