# Tasks about social networks and automatization of messages on the networks

task :send_twitter => :environment do
  puts "Beginning of sending tweet"
  Verb.send_tweet
  puts "Tweet has been sent"
end