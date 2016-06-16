class TagsController < ApplicationController
  def show
    @tag =  Tag.find_by_id(params[:id])
    if @tag
      @toots = @tag.toots.paginate(page: params[:page], per_page: 20).to_a
    else
      render file: 'public/404.html', status: :not_found
    end
  end
end
