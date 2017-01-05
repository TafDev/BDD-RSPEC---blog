class ArticlesController < ApplicationController
	before_action :find_article, only: [:show]

  def index
  end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		if @article.save
			flash[:success] = "Article has been created"
			redirect_to articles_path
		else
			flash.now[:danger] = "Article has not been created"
			render :new
		end
	end

  def show

  end

	private
  def find_article
		@article = Article.find(params[:id])
  end

	def article_params
		params.require(:article).permit(:title, :body)
	end
end
