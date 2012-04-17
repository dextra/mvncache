require 'net/http'
require "#{File.dirname(__FILE__)}/../../lib/cache/threads_synchronizer"

class FileServerController < ApplicationController
  @@synchronizer = ThreadsSynchronizer.new
    
  def index
    file_url = CacheManager.extract_requested_file_url(request.url)
    
    if !file_url || !URI.parse(file_url)
      render :text => "<h1>mvncache error</h1><h2>Invalid URI</h2><p>#{request.url}</p>"
    else
      manager = CacheManager.new(CACHE_DIR, PROXY_HOST, PROXY_PORT, PROXY_USER, PROXY_PASS)
      
      cache_file_path = nil
      status = nil
      @@synchronizer.synchronized_run_for_key(file_url, lambda {
        cache_file_path, status = manager.cache(file_url)
      })

      if not status or status.kind_of?(Net::HTTPSuccess)
        send_file cache_file_path, :type => 'application/octet-stream'
      else
        render :text => status.body, :status => status.code
      end
        
    end
  end
end
