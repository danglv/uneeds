Rails.application.config.generators do |g|
  # Disable generators we don't need.
  g.javascripts false
  g.stylesheets false
  g.test_framework  nil
end
