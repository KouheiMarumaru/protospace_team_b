class PrototypesController < ApplicationController

  before_action :set_prototype, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.all.order("created_at DESC").page(params[:page]).per(5)
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to :root, notice: 'New prototype was successfully created'
    else
      redirect_to ({ action: 'new' }), alert: 'YNew prototype was unsuccessfully created'
     end
  end

  # なぜこれで表示されたのか不明
  def show
    @new_comment = Comment.new
    @prototype = Prototype.find(params[:id])
    @comments = @prototype.comments
  end

  def edit
  end

  def update
    @prototype.update(prototype_params_for_update)
    redirect_to ({ action: 'show' }), notice: '更新完了'
  end

  def destroy
    @prototype.destroy
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:content, :status]
    )
  end

  def prototype_params_for_update
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:id, :content, :status]
    )
  end
end
