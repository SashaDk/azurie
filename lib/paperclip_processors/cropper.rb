module Paperclip
  class Cropper < Thumbnail
    def transformation_command
        
      if crop_command
        res = crop_command + super
        Rails.logger.info res.to_json
        res
      else
        super
      end
    end

    def crop_command
      target = @attachment.instance
      if target.cropping?
        ["-crop", %["#{target.crop_w}x#{target.crop_h}+#{target.crop_x}+#{target.crop_y}"], "+repage"]
      end
    end
  end
end
