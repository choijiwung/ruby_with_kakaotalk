def get_title
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
    return puts webtoon_set.sample
  
    title = webtoon_set
end
  
  
get_title
