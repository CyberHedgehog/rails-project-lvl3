# frozen_string_literal: true

class BulletinsController < ApplicationController
  before_action :set_bulletin, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  def index
    @bulletins = Bulletin.order(created_at: :desc)
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

  private

  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
  end

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
