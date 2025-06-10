class BookCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id

    if @comment.save
      respond_to do |format|
        format.js
      end
    else
      @book_comment = BookComment.new
      @book_comments = @book.book_comments
      respond_to do |format|
        format.js { render 'error.js.erb' }
      end
    end
  end

  def destroy
    @comment = BookComment.find(params[:id])
    @book = @comment.book

    if @comment.user == current_user
      @comment.destroy
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js { render js: "alert('削除権限がありません');" }
      end
    end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
