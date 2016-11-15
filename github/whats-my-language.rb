require "json"
require 'rest-client'

puts "Please enter a github username:"
username = gets.chomp

RestClient.get("https://api.github.com/users/#{username}/repos"){ |response, request, result, &block|
  case response.code
  when 200 # parse response and print out favourite language
    json = JSON.parse(response)
    array = []
    json.each do |repo|
      array << repo["language"]
    end
    favourite_language = array.uniq.max_by{ |i| array.count( i ) }
    puts "#{username}'s favourite language is " + favourite_language || "no languages for user"
  when 404
    puts "No user found for that username"
  else
    response.return!(request, result, &block)
  end
}
