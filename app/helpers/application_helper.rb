module ApplicationHelper
  def yield_with_default(holder, default)
    if content_for?(holder)
      "#{content_for(holder).squish} | #{default}"
    else
      default
    end
  end

  def cl_image_path_with_default(horse, options = {})
    if horse.photo?
      cl_image_path horse.photo.path, options
    else
      image_path 'ridemyhorse.gif', options
    end
  end

  def cl_image_tag_with_default(horse, options = {})
    if horse.photo?
      cl_image_tag horse.photo.path, options
    else
      image_tag 'ridemyhorse.gif', options
    end
  end

end
