class Api::PostsController < ApplicationController
  def index
    @posts = Post.includes(:tags)

    render json: serialize_posts(@posts)
  end

  def serialize_posts(posts)
    posts.map do |post|
      {
        title: post.title,
        id: post.id,
        tags: post.tags.map { |tag| { name: tag.name } }
      }
    end
  end

  def search
    term = params[:term]
    
    if term == nil || term == ""
      render json: []
    else
      matches = Post.includes(:tags).where('lower(title) LIKE ? OR lower(tags.name) LIKE ?', "%#{term.downcase}%",  "%#{term.downcase}%").references(:tags)
      render json: serialize_posts(matches)
    end
  end
end
