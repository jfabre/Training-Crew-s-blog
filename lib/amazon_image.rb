require 'aws/s3'
module Amazon_image
  @@bucket = 'tc_images'
  
  def amazon_url
    "http://s3.amazonaws.com/#{@@bucket}/#{name}"
  end
  def save_img(filename, file_stream)
    connect
    
    AWS::S3::Bucket.create(@@bucket) if AWS::S3::Service.buckets.empty?
    AWS::S3::S3Object.store(File.basename(filename), file_stream, @@bucket, :access => :public_read)
  end
  def update_img(from, to, file_stream = nil)
    connect
    if(file_stream.nil?)
      file_stream = AWS::S3::S3Object.find(from, @@bucket).value
    end
    delete_img(from)
    save_img(to, file_stream)
  end
  def delete_img(name)
    connect
    AWS::S3::S3Object.delete name, @@bucket
  end
  def connect
    AWS::S3::Base.establish_connection!(
      :access_key_id => S3_CONFIG['access_key_id'],
      :secret_access_key => S3_CONFIG['secret_access_key']
      )
  end
end