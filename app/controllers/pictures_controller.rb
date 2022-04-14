class PicturesController < ApplicationController
  before_action :set_picture, only: %i[ show edit update destroy ]

  def index
    @pictures = Picture.all
  end

  def show
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  def edit
    redirect_to pictures_path unless current_user.id == User.find_by(id: @picture.user_id).id
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    respond_to do |format|
      if @picture.save
        ContactMailer.contact_mail(@picture).deliver
        format.html { redirect_to picture_url(@picture), notice: "投稿しました" }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if current_user.id == User.find_by(id: @picture.user_id).id
      respond_to do |format|
        if @picture.update(picture_params)
          format.html { redirect_to picture_url(@picture), notice: "更新しました" }
          format.json { render :show, status: :ok, location: @picture }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @picture.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to pictures_path
    end
  end

  def destroy
    if current_user.id == User.find_by(id: @picture.user_id).id
      @picture.destroy
      redirect_to pictures_url, notice: "削除しました"
    else
      redirect_to pictures_path
    end
  end

  private
    def set_picture
      @picture = Picture.find(params[:id])
    end

    def picture_params
      params.require(:picture).permit(:image, :content, :image_cache)
    end
end
