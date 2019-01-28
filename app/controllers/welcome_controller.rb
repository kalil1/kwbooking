class WelcomeController < ApplicationController
  def home
    @templates = Template.all
  end
end
