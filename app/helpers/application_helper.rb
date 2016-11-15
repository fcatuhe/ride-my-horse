module ApplicationHelper
  def yield_with_default(holder, default)
    if content_for?(holder)
      "#{content_for(holder).squish} | #{default}"
    else
      default
    end
  end

  def cl_image_path_with_default(horse)
    if horse.photo?
      cl_image_path horse.photo.path, height: 300, width: 400, crop: :fill
    else
      image_path 'ridemyhorse.gif'
    end
  end
end
