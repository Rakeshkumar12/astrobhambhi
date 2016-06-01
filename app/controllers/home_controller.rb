class HomeController < ApplicationController
  def index
  	@service = Service.all
  end

  def astroservices
  end

  def vastu
  end

  def numerology
  end

  def shop
  end

  def horoscope
  end

  def contact
  end
end
