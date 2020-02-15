unless Rails.env.development? || Rails.env.test?
    CarrierWave.configure do |config|
      config.fog_credentials = {
        provider: 'AWS',
        aws_access_key_id: 'AKIAV6DFY5WZ5C4HB5HF',
        aws_secret_access_key: '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',
        region: 'ap-northeast-1'
      }
  
      config.fog_directory  = 'rails-photo-avatar'
      config.cache_storage = :fog
    end
  end