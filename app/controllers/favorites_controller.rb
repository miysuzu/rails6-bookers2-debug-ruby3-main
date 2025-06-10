class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save

    respond_to do |format|
      format.js { render :create, content_type: 'application/javascript' }
      format.html { head :ok }
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy if favorite

    respond_to do |format|
      format.js { render :destroy, content_type: 'application/javascript' }
      format.html { head :ok }
    end
  end
end
