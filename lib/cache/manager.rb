require 'fileutils'
require "#{File.dirname(__FILE__)}/download"

class CacheManager
  def initialize(cache_dir, proxy_host = nil, proxy_port = nil, proxy_user = nil, proxy_pass = nil)
    @cache_dir = cache_dir
    @proxy_host, @proxy_port = proxy_host, proxy_port
    @proxy_user, @proxy_pass = proxy_user, proxy_pass
  end
  
  def self.extract_requested_file_url(full_url)
    match = /.+:\/(?:\/.+)*\/(.+:\/\/.*)/.match(full_url)
    match == nil ? nil : match[1]
  end
  
  def generate_dirname(url)
    uri = URI.parse(url)
    return File.join(uri.host, File.dirname(uri.path))
  end
  
  def generate_cache_dirname(url)
    return File.join(@cache_dir, generate_dirname(url))
  end
  
  def generate_filename(url)
    return /\/([^\/]+)$/.match(url)[1]
  end
  
  def generate_cache_filepath(url)
    return File.join(generate_cache_dirname(url), generate_filename(url))
  end
  
  def ensure_dir_exists(dir)
    if not File.exists?(dir)
      FileUtils.mkdir_p(dir)
    end
    return File.exists?(dir)
  end

  def cache(file_uri)
    ensure_dir_exists(generate_cache_dirname(file_uri))
    
    cache_filepath = generate_cache_filepath(file_uri)

    status = nil
    if File.exists?(cache_filepath)
      @download = nil
    else
      @download = Download.new(@proxy_host, @proxy_port, @proxy_user, @proxy_pass)
      status = @download.run(file_uri, cache_filepath)
    end
    return cache_filepath, status 
  end
  
  def downloaded_file?
    @download ? true : false
  end
end
