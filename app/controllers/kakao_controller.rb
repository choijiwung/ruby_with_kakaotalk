require 'msgmaker'
require 'parser'

class KakaoController < ApplicationController
  @@key = Msgmaker::Keyboard.new
  @@msg = Msgmaker::Message.new
  
  
  def keyboard
    render json: {"type": "text"}
  end

  def message

    user_msg = params[:content] 
    
    pic = false

    case user_msg
      when "영화"
        movie = Parser::Movie.new
        msg = movie.naver + [" 강추!!", " 나도 안봤지만 추천", " 보던가말던가"].sample
      when "고양이"
        pic = true
        animal = Parser::Animal.new
        msg = "나만고양이없어"
      when "로또"
        msg =  (1..46).to_a.sample(6).to_s
      when "메뉴"
        msg=["한식","양식","분식","편의점","다이어트","패스트푸드"].sample
      when "웹툰"
        webtoon = Parser::Webtoon.new
        msg = webtoon.get_info.to_a 
        title = msg[0]
        url = msg[1]
        score = msg[2]
        msg = "제목은 #{title} 평점은 #{score}이야"
      else
        msg = "야옹"
    end
    
    
    if pic
      result = {
        message: @@msg.getPicMessage(msg.to_s, animal.cat),
        keyboard: @@key.getBtnKey(["영화","고양이","로또","메뉴","웹툰"])
      }
    else
      result = {
        message: @@msg.getMessage(msg.to_s),
        keyboard: @@key.getBtnKey(["영화","고양이","로또","메뉴","웹툰"])
      }
    end
    render json: result
  end
  
  def friend_add
    user_key = params[:user_key]
    #새로운 유저를 저장해주세요
    render nothing: true
  end
  
  def friend_add
    User.create(user_key: params[:user_key], chat_room: 0)
    render nothing: true
  end
  
  def chat_room
    user = User.find_by(user_key: params[:user_key])
    user.plus
    user.save
    render nothing: true
  end
  
end
  