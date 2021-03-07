RakutenWebService.configure do |c|
    # アプリケーションID
    c.application_id = ENV['KEY']
    # アフィリエイト
    c.affiliate_id = ENV['affiliate_key']
end