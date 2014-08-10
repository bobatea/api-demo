#
# User controller
#
class PicPicAPI < Grape::API

  post :picupload do
    new_pic = current_user.pics.new
    image_file = params[:pic_file]
    new_pic.s3_filename = "#{image_file.original_filename.downcase}.#{Time.now.to_i.to_s}"
    obj = $Bucket.objects.create(new_pic.s3_filename, :file => image_file) rescue nil

    error!('Inner error, S3', 500) unless obj

    obj.acl = :public_read
    new_pic.url = obj.public_url.to_s
    new_pic.description = params[:description]

    if new_pic.save
      {
        success: true,
        info: new_pic
      }
    else
      {
        success: false,
        messages: new_pic.errors.messages
      }
    end
  end
end