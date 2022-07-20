class SmsApi
  def initialize()
    @apikey  = ENV['SEMAPHORE_API_KEY']
    @sendername  = nil
  end

  def send_message(message: nil, number: nil)
    require 'rest-client'
    require 'json'
    res = nil

    payload = {
      apikey:     @apikey,
      number:     number,
      message:    message,
      sendername: @sendername
    }.to_json

    req = RestClient::Request.new({
      method: :post,
      url: 'https://semaphore.co/api/v4/messages',
      payload: payload,
      headers: { :accept => :json, content_type: :json }
    }).execute do |response, request, result|
      res = JSON.parse(response.body)
      oh = OptionalHash.new(res)
      oh.value.first['status'].present? rescue false
    end
  end

  def send_broadcast_message(message: nil, number: nil)
    require 'rest-client'
    require 'json'
    res = nil

    payload = {
      apikey:     @apikey,
      number:     number,
      message:    message,
      sendername: @sendername
    }.to_json

    req = RestClient::Request.new({
      method: :post,
      url: 'https://semaphore.co/api/v4/messages',
      payload: payload,
      headers: { :accept => :json, content_type: :json }
    }).execute do |response, request, result|
      res = JSON.parse(response.body)
      oh = OptionalHash.new(res)
      oh.value.first['status'].present? rescue false
    end
  end

  def get_account(message: nil, number: nil)
    require 'rest-client'
    require 'json'
    res = nil

    payload = {
      apikey:     @apikey,
    }.to_json

    req = RestClient::Request.new({
      method: :get,
      url: 'https://api.semaphore.co/api/v4/account',
      payload: payload,
      headers: { :accept => :json, content_type: :json }
    }).execute do |response, request, result|
      @res = JSON.parse(response.body)
    end
  end
end