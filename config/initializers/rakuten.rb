RakutenWebService.configure do |c|
    # アプリケーションID
    c.application_id = ENV['API_KEY']
    # アフィリエイト
    c.affiliate_id = ENV['AFFILIATE_KEY']
end