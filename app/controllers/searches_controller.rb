class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @content = params[:content]
    @model = params[:model]
    @method = params[:method]
    
    if @model == "User"
      @records = User.search_for(@content, @method)
    else
      @records = Book.search_for(@content, @method)
    end
  end
  
end
