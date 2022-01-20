# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :set_bulletin, except: %i[index new create]
  before_action :authenticate_user!, except: %i[index show]
  def index
    @categories = Category.all
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result(distinct: true).order(created_at: :desc).page params[:page]
    # @bulletins = Bulletin.published.order(created_at: :desc)
  end

  def show; end

  def new
    @bulletin = Bulletin.new
  end

  def create
    @bulletin = Bulletin.new(user: current_user, **bulletin_params)
    if @bulletin.save
      redirect_to bulletin_path(@bulletin)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @bulletin.update(bulletin_params)
      redirect_to bulletin_path(@bulletin)
    else
      render :edit, status: :unprocessible_entity
    end
  end

  def destroy
    @bulletin.destroy
    redirect_to request.referer || bulletins_path
  end

  def publish
    @bulletin.moderate!
    redirect_to profile_path
  end

  def archive
    @bulletin.archive!
    redirect_to profile_path
  end

  def approve
    @bulletin.approve!
    redirect_to request.referer
  end

  def reject
    @bulletin.reject!
    redirect_to request.referer
  end

  private

  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
  end

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
