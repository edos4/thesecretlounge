class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    begin
      api = SmsApi.new
      acct = api.get_account()
      @balance = acct['credit_balance']
    rescue => e
      @balance = 'Please refresh the browser after 2 minutes'
    end
    @citizen_count = Citizen.count
    @tag_count = Tag.count
  end
end
