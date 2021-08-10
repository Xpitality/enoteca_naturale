if Rails.application.credentials.config[:aws] && Rails.application.credentials.config[:aws][:s3][:access_key_id] && Rails.application.credentials.config[:aws][:s3][:secret_access_key]
  Paperclip::Attachment.default_options.merge!(
      storage: :fog,
      fog_credentials: {
          provider: 'AWS',
          aws_access_key_id: Rails.application.credentials.config[:aws][:s3][:access_key_id],
          aws_secret_access_key: Rails.application.credentials.config[:aws][:s3][:secret_access_key],
          region: Rails.application.credentials.config[:aws][:s3][:region],
      },
      fog_directory: Rails.application.credentials.config[:aws][:s3][:bucket],
      fog_host: Rails.env.production? ? Rails.application.credentials.config[:aws][:s3][:host_alias] : nil
  )

  Spree::Image.attachment_definitions[:attachment].delete(:url)
  Spree::Image.attachment_definitions[:attachment].delete(:path)
end


# if ENV['CLOUDINARY_URL']
#   require 'paperclip/cloudinary'
#
#   Paperclip::Attachment.default_options[:storage] = :cloudinary
#
#   Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
#   Paperclip::Attachment.default_options[:s3_host_name] = 'eu-west-1.amazonaws.com'
#
#
#
#   Spree::Image.attachment_definitions[:attachment].delete(:url)
#   Spree::Image.attachment_definitions[:attachment].delete(:path)
#   Spree::Image.attachment_definitions[:attachment].delete(:default_url)
#   Spree::Image.attachment_definitions[:attachment][:path] = 'spree/products/:id/:style/:filename'
#   Spree::Image.attachment_definitions[:attachment][:cloudinary_url_options] = {
#     default: { secure: true }
#   }
# end
