module ApplicationHelper

# create djatoka-friendly non-ssl image path
  def nonssl_image_uri(pid,datastream_id)
    datastream_disseminator_url(pid,datastream_id).gsub(/\Ahttps/,'http')
  end

  # create an image tag from an IIIF image server
  def iiif_image_tag(image_pid,options)
    image_tag iiif_image_url(image_pid, options), :alt => options[:alt].presence, :class => options[:class].presence
  end

  # return the IIIF image url
  def iiif_image_url(image_pid, options)
    size = options[:size] ? options[:size] : 'full'
    region = options[:region] ? options[:region] : 'full'
    "#{IIIF_SERVER['url']}#{image_pid}/#{region}/#{size}/0/default.jpg"
  end

  # return a square image of the supplied size (in pixels)
  def iiif_square_img_path(image_pid, size)
    img_info = get_image_metadata(image_pid)
    width = img_info[:width]
    height = img_info[:height]
    if width > height
      offset = (width - height) / 2
      iiif_image_url(image_pid,
                     {:region => "#{offset},0,#{height},#{height}", :size => "#{size},#{size}"})
    elsif height > width
      offset = (height - width) / 2
      iiif_image_url(image_pid,
                     {:region => "0,#{offset},#{width},#{width}", :size => "#{size},#{size}"})
    else
      iiif_image_url(image_pid, {:size => "#{size},#{size}"})
    end
  end

  # returns a hash with width/height from IIIF info.json response
  def get_image_metadata(image_pid)
    iiif_response = Typhoeus::Request.get(IIIF_SERVER['url'] + image_pid + '/info.json')
    if iiif_response.response_code == 200
      iiif_info = JSON.parse(iiif_response.body)
      img_metadata = {:height => iiif_info["height"].to_i, :width => iiif_info["width"].to_i}
    else
      img_metadata = {:height => 0, :width => 0}
    end
    img_metadata
  end

  def get_image_json(image_pid)
    "#{IIIF_SERVER['url']}#{image_pid}/info.json"
  end

end
