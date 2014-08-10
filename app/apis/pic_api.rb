#
# User controller
#
class PicPicAPI < Grape::API

  namespace :protected do

    # Auth
    before do
      error!('Unauthorized', 401) unless authenticate!
    end

    post :picupload do

      error!('Token without user', 500) unless current_user

      new_pic = current_user.pics.new
      image_file = params[:pic_file]

      new_pic.s3_filename = "#{image_file.filename.downcase}.#{Time.now.to_i.to_s}"
      obj = $Bucket.objects.create(new_pic.s3_filename, :file => image_file.tempfile) rescue nil

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
end