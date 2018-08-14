require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(15)
  # grid = []
  # grid_size.times { grid << source.sample }
  # return grid.slice(9)
  end

  def score
    @result = params[:game]
    @score = 0
    url = "https://wagon-dictionary.herokuapp.com/#{@result}/"
    attempt_hash = JSON.parse(open(url).read)
    @letters = params[:letters].split.map { |char| char.downcase }
    correct_word = @result.downcase.chars.all? do |char|
      @result.count(char) <= @letters.count(char)
    end

    if correct_word && attempt_hash['found']
      @score = (@result.length**2)
      @message = 'Well done!'
    elsif correct_word
      @message = 'not an english word'
    else
      @message = 'not in the grid'
    end
  end
end
