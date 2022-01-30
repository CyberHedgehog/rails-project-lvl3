# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  def index
    @categories = Category.all
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result(distinct: true).published.order(created_at: :desc).page params[:page]
  end

  def show
    bulletin
  end

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

  def edit
    bulletin
  end

  def update
    if bulletin.update(bulletin_params)
      redirect_to bulletin_path(bulletin)
    else
      render :edit, status: :unprocessible_entity
    end
  end

  def destroy
    bulletin.destroy
    redirect_to request.referer || bulletins_path
  end

  def to_moderate
    bulletin.moderate!
    redirect_to profile_path
  end

  def archive
    bulletin.archive!
    redirect_to profile_path
  end

  def publish
    bulletin.publish!
    redirect_to request.referer
  end

  def reject
    bulletin.reject!
    redirect_to request.referer
  end

  private

  def bulletin
    @bulletin ||= Bulletin.find(params[:id])
  end

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
