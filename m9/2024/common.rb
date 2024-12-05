require 'awesome_print'
require 'pry'
require 'optimist'
require 'httparty'


class AOC
  include HTTParty
  base_uri 'adventofcode.com'

  def initialize(year=2024)
    @year = year
    @cookie_hash = HTTParty::CookieHash.new
    set_cookies

    @options = { headers: {'Cookie' => @cookie_hash.to_cookie_string }}
  end
  
  def day(day)
    unless File.exist? 'input.txt'
      File.open('input.txt', 'w+') {_1.write(get_task_input(day))}
    end
  end

  private

  def set_cookies
    @cookie_hash.add_cookies(ENV['AOC_COOKIE'])
  end
  
  def get_task_input(day)
    self.class.get "/#{@year}/day/#{day}/input", @options
  end
end


$o = Optimist::options {opt :test}
$get = AOC.new(2024)
