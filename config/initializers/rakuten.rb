RakutenWebService.configure do |c|
    # アプリケーションID
    c.application_id = ENV['RWS_APPLICATION_ID']
    # アフィリエイト
    c.affiliate_id = ENV['AFFILIATE_KEY']
end