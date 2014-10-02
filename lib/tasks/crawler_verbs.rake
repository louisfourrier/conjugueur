
# Hellocoton crawler.Mode
task :coindesmots_crawler => :environment do
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  HEADERS_HASH = {"User-Agent" => "Ruby/#{RUBY_VERSION}", "read_timeout" => "30"}
  # Base Url
  BASE_URL = "http://www.lecoindesmots.com/dictionnaire-des-rimes/verbes"
  array_explore = ("A".."Z").to_a 
  links = []
  array_explore.each do |letter|
    letter_link = BASE_URL.to_s + "-" + letter
    links << letter_link  
  end
  
  puts links.to_s
  
  
  links2 = []
  main_page = Nokogiri::HTML(open(BASE_URL))
  page_links = main_page.css('div.user-item a.avatar')
  page_links.each do |l|
    if !l['href'].match("https://twitter.com/")
      links2 << l['href']
    end
  end



  
  results =[]
  links.each do |href|
    puts "Crawling of " + href.to_s
    page = Nokogiri::HTML(open(href))
    blog_link = page.css('#profile ul.profile-infos li.site a').first
    puts Website.add_url_from_crawler(blog_link['href'], 1, 1, "mode", "france", "http://www.hellocoton.fr/annuaire/mode")
  end # done: hrefs.each


  puts results.to_s
end



task :verbs_crawler => :environment do
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  HEADERS_HASH = {"User-Agent" => "Ruby/#{RUBY_VERSION}", "read_timeout" => "30"}
  # Base Url
  BASE_URL = "http://www.lecoindesmots.com/dictionnaire-des-rimes/verbes"
  array_explore = ("A".."Z").to_a 
  links_to_crawl = []
  array_explore.each do |letter|
    letter_link = BASE_URL.to_s + "-" + letter + ".html"
    links_to_crawl << letter_link  
  end
  
  
  ban_links = []
  array_explore.each do |letter|
    ban_links << ("verbes-" + letter + ".html")
  end
  
  puts "Ban Links"
  puts ban_links.to_s
  
  verbs = []
  

  links_to_crawl.each do |page|
   
    main_page = Nokogiri::HTML(open(page.to_s))
    page_links = main_page.css('div.entry.category a')
    
    page_links.each do |l|
      if l['href'].match("conjugaison_")
        verbs << l.text
      end
    end
    
  end
  
  verbs.each do |v|
    Verb.create(:content => v.to_s)
  end
  
end

task :conjugueur_crawler => :environment do
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  HEADERS_HASH = {"User-Agent" => "Ruby/#{RUBY_VERSION}", "read_timeout" => "30"}
  # Base Url
  BASE_URL = "http://leconjugueur.lefigaro.fr/conjugaison/verbe/"

  Verb.find_each do |verb|
    begin
    puts "STARTING crawling of " + verb.html_name.to_s + " id : " + verb.id.to_s
    verb_link = BASE_URL.to_s + verb.html_name.to_s + ".html"
    main_page = Nokogiri::HTML(open(verb_link.to_s))
    verb_page = main_page.css('#Top')
    sanitize_html = verb_page.to_html.encode!('UTF-8', :undef => :replace, :invalid => :replace, :replace => "") 
    verb.update(:page_content => sanitize_html)
    rescue
    end
  end
  
end


task :conjugueur_crawler_bis => :environment do
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  HEADERS_HASH = {"User-Agent" => "Ruby/#{RUBY_VERSION}", "read_timeout" => "30"}
  # Base Url
  BASE_URL = "http://leconjugueur.lefigaro.fr/conjugaison/verbe/"

  Verb.where('page_content IS NULL').find_each do |verb|
    begin
    puts "STARTING crawling of " + verb.html_name.to_s + " id : " + verb.id.to_s
    verb_link = BASE_URL.to_s + verb.html_name.to_s + ".html"
    main_page = Nokogiri::HTML(open(verb_link.to_s))
    verb_page = main_page.css('#Top')
    sanitize_html = verb_page.to_html.encode!('UTF-8', :undef => :replace, :invalid => :replace, :replace => "") 
    verb.update(:page_content => sanitize_html)
    rescue
    end
  end
  
end

task :conjugueurex_crawler => :environment do
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  HEADERS_HASH = {"User-Agent" => "Ruby/#{RUBY_VERSION}", "read_timeout" => "30"}
  # Base Url
  BASE_URL = "http://leconjugueur.lefigaro.fr/conjugaison/verbe/"
  first_verb = Verb.first
  
  puts first_verb.content.to_s
  
  example_url = "http://leconjugueur.lefigaro.fr/conjugaison/verbe/" + first_verb.content.to_s + ".html"
  puts example_url
  
  main_page = Nokogiri::HTML(open(example_url.to_s))
  verb_page = main_page.css('#Top')
  puts verb_page.to_html.to_s
  
  first_verb.update(:page_content => verb_page.to_html)
  
  
end

task :definition_crawler => :environment do
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  HEADERS_HASH = {"User-Agent" => "Ruby/#{RUBY_VERSION}", "read_timeout" => "30"}
  # Base Url
  BASE_URL = "http://la-conjugaison.nouvelobs.com/definition/"

  Verb.find_each do |verb|
    begin
      puts "STARTING crawling of " + verb.html_name_bis.to_s + " id : " + verb.id.to_s
      verb_link = BASE_URL.to_s + verb.html_name_bis.to_s + ".php"
      main_page = Nokogiri::HTML(open(verb_link.to_s))
      verb_page = main_page.css('#contenu h2.mode1 + .bloc')
      sanitize_html = verb_page.to_html.encode!('UTF-8', :undef => :replace, :invalid => :replace, :replace => "")
      puts sanitize_html.to_s
      verb.update(:definition => sanitize_html)
    rescue
    end
  end
  
  
end


task :verb_global_update => :environment do
  Verb.find_each do |verb|
      puts verb.id.to_s
      verb.get_synonyms
      verb.fill_tenses
    end
end

