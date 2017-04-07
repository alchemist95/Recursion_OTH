Rails.application.config.middleware.use OmniAuth::Builder do

provider :facebook, "1865068787069627", "7adada9cf34fb6adbbc319f6cb65f47f"
OmniAuth.config.logger = Rails.logger
provider :google_oauth2, '1000702092234-r8358gkh1k1q0vespfghuo38ro9p4gjo.apps.googleusercontent.com', 'U9abhTTsZDp5801BWD2ZwPOx', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}

end