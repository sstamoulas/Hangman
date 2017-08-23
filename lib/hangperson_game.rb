class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letter)
    letter = letter.to_s.downcase
    if letter.empty?
      raise ArgumentError 
    elsif  !(letter =~ /[[:alpha:]]/)
      raise ArgumentError
    end
    unless @guesses.count(letter) > 0 || @wrong_guesses.count(letter) > 0
      unless @word.count(letter) > 0
        @wrong_guesses << letter
      else
        @guesses << letter
      end
      true
    else
      false
    end
  end

  def word_with_guesses
    str = ""
    @word.split("").each do |letter|
      if @guesses.include? letter
        str += letter
      else
        str += "-"
      end
    end
    str
  end

  def check_win_or_lose
    result = word_with_guesses
    if result.eql?(@word)
      :win
    elsif @wrong_guesses.length >= 7
      :lose
    else
      :play
    end
  end

end
