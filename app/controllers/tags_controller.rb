class TagsController < ApplicationController
  def show
    @tag =  Tag.find_by_id(params[:id])
    if @tag
      @toots = @tag.toots
    else
      render file: 'public/404.html', status: :not_found
    end
  end
end
