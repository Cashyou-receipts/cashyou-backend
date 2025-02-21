require "aws-sdk-s3"
# require_relative "../environment.rb"

class AwsS3Service
  CLIENT = Aws::S3::Client.new(
    access_key_id: ENV['S3_ACCESS_KEY'],
    secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
    force_path_style: true, 
    region: ENV['S3_BUCKET_REGION'],
    retry_limit: 0
  )

  def list_buckets
    resp = CLIENT.list_buckets
    resp.buckets.map(&:name)
  end

  def list_objects(bucket:)
    CLIENT.list_objects_v2(bucket: bucket).contents
  end

  def delete_receipt(keys:)
    keys = Array(keys)
    resp = CLIENT.delete_objects({
      bucket: ENV["S3_BUCKET_NAME"],
      delete: {
        objects: keys.map{ |key| {key: key}},
        quiet: false
      },
    })
    resp
  end

  def generate_presigned_url(bucket_name: ENV["S3_BUCKET_NAME"], object_key:, expires_in: 3600)
    signer = Aws::S3::Presigner.new(client: CLIENT)

    signer.presigned_url(
      :get_object,
      bucket: bucket_name,
      key: object_key,
      expires_in: expires_in
    )
  end
end