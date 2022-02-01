# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  def index
    @categories = Category.all
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result(distinct: true).published.order(created_at: :desc).page params[:page]
  end

  def show
    bulletin
  end

  def new
    authorize [:bulletin]
    @bulletin = Bulletin.new
  end

  def create
    authorize [:bulletin]
    @bulletin = Bulletin.new(user: current_user, **bulletin_params)
    if @bulletin.save
      redirect_to bulletin_path(@bulletin)
    else
      render :new
    end
  end

  def edit
    authorize bulletin
    bulletin
  end

  def update
    authorize bulletin
    if bulletin.update(bulletin_params)
      redirect_to bulletin_path(bulletin)
    else
      render :edit, status: :unprocessible_entity
    end
  end

  def destroy
    authorize bulletin
    bulletin.destroy
    redirect_to request.referer || bulletins_path
  end

  def to_moderate
    authorize bulletin
    bulletin.moderate!
    redirect_to profile_path
  end

  def archive
    authorize bulletin
    bulletin.archive!
    redirect_to profile_path
  end

  def publish
    authorize bulletin
    bulletin.publish!
    redirect_to request.referer
  end

  def reject
    authorize bulletin
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
