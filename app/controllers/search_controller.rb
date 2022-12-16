class SearchController < ApplicationController
  def index
    @posts = Post.search(params[:search], fields: %i[title body])
    @posts = Post.search('*') if params[:search].blank?

    respond_to do |format|
      format.html  { render :index }
      format.turbo_stream do
        render turbo_stream:
          turbo_stream.update('posts',
            partial: 'posts/posts',
            locals: { posts: @posts })
      end
    end
  end
end
