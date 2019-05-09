require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    9.times do
      @letters << ('A'..'Z').to_a.sample
    end
    @letters
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    filepath = "https://wagon-dictionary.herokuapp.com/#{@word}"
    attempt_one = open(filepath).read
    answer = JSON.parse(attempt_one)
    # return { message: "not an english word", score: 0, time: time } unless answer["found"] == true
    @word.upcase.split('').each do |letter|
      if @letters.include?(letter)
        @letters.split.delete_at(@letters.index(letter))
        if answer['found'] == true
          @message = 'well done'
        else
          @message = 'not an english word'
        end
      else
        @message = 'not in the grid'
      end
    end
  end
end


    # if answer["found"]
    #   if @word.upcase.split('').each do |letter|
    #        @letters.include?(letter)
    #        @letters.split.delete_at(@letters.index(letter))
    #      end
    #     @message = 'well done'
    #   else
    #     @message = 'not in the grid'
    #   end
    # else
    #   @message = 'not an english word'
    # end
