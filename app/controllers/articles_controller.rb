require 'blacklight/catalog'

class ArticlesController < ApplicationController
  include Blacklight::Catalog
  

  def show
    @document = SerialSolutions::Link360.new(params[:openurl])

    render "show", :layout => "no_sidebar"
  end

end
