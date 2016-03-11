require 'unirest'

response = Unirest.get "https://udayogra-find-gender-by-name-v1.p.mashape.com/analysis?firstname=jessica",
  headers:{
    "X-Mashape-Key" => "fIxiyCVxy2mshQ5nhek8j1b3e76Mp1zOT9XjsnRMHynAtdg1hQ",
    "Accept" => "application/json"
  }

puts response.body
