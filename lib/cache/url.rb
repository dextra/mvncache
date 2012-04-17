class URL
  def initialize(url)
    @url = url
    @uri = URI.parse(@url) rescue nil
  end

  def valid?
    @uri && ["http","https"].include?(@uri.scheme) || false
  end
  
  def filename()
    return File.basename(@uri.path) 
  end
  
  def filepath()
    return @url.gsub(/http(s)?:\/\//, '')
  end
end