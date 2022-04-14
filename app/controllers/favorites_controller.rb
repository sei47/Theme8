class FavoritesController < ApplicationController

  def index
    @favorites = current_user.favorite_pictures
  end

  def create
    favorite = current_user.favorites.create(picture_id: params[:picture_id])
    redirect_to pictures_path, notice: "#{favorite.picture.user.name}の投稿をお気に入り登録しました"
  end

  def destroy
    favorite = current_user.favorites.create(picture_id: params[:picture_id]).destroy
    redirect_to pictures_path, notice: "#{favorite.picture.user.name}の投稿をお気に入りから解除しました"
  end
end
