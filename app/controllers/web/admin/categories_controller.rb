# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  before_action :authorize_admin

  def index
    @categories = Category.order(created_at: :desc)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: t('categories.create.success')
    else
      render :new
    end
  end

  def edit
    category
  end

  def update
    if category.update(category_params)
      redirect_to admin_categories_path, notice: t('categories.update.success')
    else
      render :edit, status: :unprocessible_entity
    end
  end

  def destroy
    if category.destroy
      redirect_to admin_categories_path, notice: t('categories.delete.success')
    else
      redirect_to admin_categories_path, alert: t('categories.delete.error')
    end
  end

  private

  def category
    @category ||= Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def authorize_admin
    authorize %i[admin category]
  end
end
