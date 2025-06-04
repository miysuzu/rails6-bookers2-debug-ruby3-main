class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @keyword = params[:keyword]
    @match = params[:match]

    if @range == "User"
      @users = User.where("name #{sql_match_operator(@match)}", sql_match_keyword(@keyword, @match))
    else
      @books = Book.where("title #{sql_match_operator(@match)}", sql_match_keyword(@keyword, @match))
    end

  end

  private

  # SQL演算子を返す（LIKEを常に使用）
  def sql_match_operator(match)
    "LIKE ?"
  end

  # キーワードのパターンを返す
  def sql_match_keyword(keyword, match)
    case match
    when "perfect"
      keyword
    when "forward"
      "#{keyword}%"
    when "backward"
      "%#{keyword}"
    when "partial"
      "%#{keyword}%"
    else
      "%#{keyword}%"
    end
  end
end
