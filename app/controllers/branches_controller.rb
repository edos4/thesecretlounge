class BranchesController < ApplicationController
  before_action :set_branch, only: %i[ show edit update destroy ]

  def index
    #@search = Branch.reverse_chronologically.ransack(params[:q])
    @branches = Branch.all

    respond_to do |format|
      format.any(:html, :json) { @branches = @branches }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @branch
  end

  def new
    @branch = Branch.new
  end

  def edit
  end

  def create
    @branch = Branch.new(branch_params)
    @branch.save!

    respond_to do |format|
      format.html { redirect_to @branch, notice: 'Branch was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @branch.update!(branch_params)
    respond_to do |format|
      format.html { redirect_to @branch, notice: 'Branch was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @branch.destroy
    respond_to do |format|
      format.html { redirect_to branches_url, notice: 'Branch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_branch
      @branch = Branch.find(params[:id])
    end

    def branch_params
      params.require(:branch).permit(:name)
    end
end
