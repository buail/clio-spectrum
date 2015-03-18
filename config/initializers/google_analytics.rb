module GoogleAnalytics
  mattr_accessor :web_property_id
end

# Change to your Google Web id
GoogleAnalytics.web_property_id = case Rails.env.to_s

  # PROD
  when 'clio_prod'
    'UA-28923110-1'

  # TEST
  when 'clio_test'
    'UA-28923110-3'

  # DEV
  when 'clio_dev'
    'UA-28923110-4'

  # Test needs an Id too, or it'll get JS errs
  when 'test'
    'UA-28923110-5'

  when 'development'
    'UA-28923110-5'

  else
    nil
end
