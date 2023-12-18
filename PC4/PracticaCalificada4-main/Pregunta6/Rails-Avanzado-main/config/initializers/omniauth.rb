# Replace API_KEY and API_SECRET with the values you got from Twitter
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "RxOI3GugmOtewx24IPSQ3VCpc", "NCzvpnWAChbYKYd5qXTkUjcSqQTClhkiw9InaZxHzTPkl1pc45"
end