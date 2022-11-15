class MembersController < ApplicationController
  before_action :set_member, only: %i[ show edit update destroy ]

  def import

  end

  def upload

  end

  def check
    @member = Member.find_by(membership_card_number: params['membership_card_number'])
    if @member.present?
      render json: @member.id
    else
      render json: {message: 'Not found'}
    end
  end

  def index
    if params[:branch_id].present?
      @members = Member.where(branch_id: params[:branch_id])
    else
      @members = Member.all
    end

    respond_to do |format|
      format.any(:html, :json) { @members = @members }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @member
    @services = @member.member_services
    @service_list = Service.all
  end

  def new
    @member = Member.new
  end

  def edit
  end

  def create
    @member = Member.new(member_params)
    @member.save!

    respond_to do |format|
      format.html { redirect_to @member, notice: 'Member was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @member.update!(member_params)
    respond_to do |format|
      format.html { redirect_to @member, notice: 'Member was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_service
    service_ids = params['service']['tag_ids'].reject(&:empty?).map(&:to_i)
    member = Member.find(params['service']['member_id'])

    service_ids.each do |si|
      member.services << Service.find(si)
    end

    redirect_to "/members/#{member.id}"
  end

  def delete_service
    member_service = MemberService.find(params[:id])
    member = member_service.member
    member_service.destroy
    redirect_to "/members/#{member.id}"
  end

  private
    def set_member
      @member = Member.find(params[:id])
    end

    def member_params
      params.require(:member).permit(:membership_date, :name, :email, :contact_number, :address, :branch_id, :slug, :membership_card_number, :expiry_date, :beauty_bank, :loyalty_points)
    end
end
