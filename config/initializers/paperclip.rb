# Override default S3 URL structure
Paperclip::Attachment.default_options[:url]  = ':s3_domain_url'
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'

# Set endpoint
Paperclip::Attachment.default_options[:s3_host_name] = 's3-us-east-2.amazonaws.com'