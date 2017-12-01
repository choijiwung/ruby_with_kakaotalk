require 'nokogiri'
require 'open-uri'
require 'rest-client'

module Parser
    class Movie
        def naver
            # 네이버 현재상영영화중 하나를 랜덤으로 뽑아주는 코드
        
            doc = Nokogiri::HTML(open("http://movie.naver.com/movie/running/current.nhn"))
            movie_title = Array.new
            
            doc.css("ul.lst_detail_t1 dt a").each do |title|
            	movie_title << title.text
            end
            
            title = movie_title.sample
            return "<" + title + ">"
        end
    end
    
    class Animal
        def cat
            cat_xml = RestClient.get 'http://thecatapi.com/api/images/get?format=xml&type=jpg'
            doc = Nokogiri::XML(cat_xml)
            cat_url = doc.xpath("//url").text
            
            return cat_url
        end
    end
    
    class Webtoon
        def get_info
        require 'rest-client'
        require 'json'
      
        url ="http://webtoon.daum.net/data/pc/webtoon/list_daily_ranking/finished?timeStamp=1510903239849"
        result = RestClient.get url
        result=JSON.parse(result)
        # puts result
        # puts result.class
        webtoon_set = Array.new
        
        
        result['data'].each do |data|
          
            #puts data.keys
            artist = data['cartoon']['artists'].collect {|artist| artist["name"]}
            title = data['title']
            score = data['averageScore'].round(1)
            image_url = data['appThumbnailImage']['url']
            url = data['url']
            
            webtoon_info = Array.new 
            webtoon_info << title
            webtoon_info << image_url
            webtoon_info << score
            
            webtoon_set << webtoon_info
            # p webtoon_title 
            # p webtoon_set
            # p "-----------"
            #webtoon_title.pop(3)
                       
            
            end
        webtoon_information = webtoon_set.sample
        return webtoon_information
            end
        
    end
end