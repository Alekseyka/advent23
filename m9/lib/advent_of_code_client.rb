require 'httparty'

class AdventOfCodeClient
  include HTTParty
  base_uri 'adventofcode.com'

  def initialize(year=2023)
    @year = year
    @cookie_hash = HTTParty::CookieHash.new
    set_cookies

    @options = { headers: {'Cookie' => @cookie_hash.to_cookie_string }}
  end

  def get_task_input(day)
    self.class.get "/#{@year}/day/#{day}/input", @options
  end

  private

  def set_cookies
    @cookie_hash.add_cookies(ENV['AOC_COOKIE'])
  end
end