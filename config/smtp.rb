SMTP_SETTINGS = {
  address: "smtp.sendgrid.net",
  authentication: :plain,
  domain: "heroku.com",
  enable_starttls_auto: true,
  password: ENV.fetch("SMTP_PASSWORD"),
  port: "587",
  user_name: ENV.fetch("SMTP_USERNAME")
}

if ENV["EMAIL_RECIPIENTS"].present?
  Mail.register_interceptor RecipientInterceptor.new(ENV["EMAIL_RECIPIENTS"])
end
