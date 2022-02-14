require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
    # @letters << %w[A E I O U].sample(3)
      # raise
  end

  def score
    @guess = params[:guess]
    @letters = params[:letters].split
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{@guess}")
    json = JSON.parse(response.read)
    each_letter = @guess.chars
    if each_letter.map.all? { |letter| @letters.include?(letter) }
      if json['found']
        @score = "Congratulations #{@guess} is an English word!"
      else
        @score = "I'm sorry, that word is not in the dictionary!"
      end
    else
      @score = "Sorry, but your answer should only use characters #{@letters.join(' ')}!"
    end
  end

end
       # split guess
    # see if letters in guess appear in letters

        # def english_word?(word)
    #   response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    #   json = JSON.parse(response.read)
    #   return json['found']
    # end
