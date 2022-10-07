class ScansController < ApplicationController
  before_action :authenticate_user!
  def index
    @member_count = Member.count
    @branch_count = Branch.count
  end
end
