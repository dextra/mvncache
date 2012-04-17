require 'uri'
require 'net/http'
require 'zlib' 

class Download
  def initialize(proxy_addr, proxy_port, proxy_user, proxy_pass)
    @proxy_addr, @proxy_port = proxy_addr, proxy_port
    @proxy_user, @proxy_pass = proxy_user, proxy_pass
  end
  
  def run(uri_to_download, filepath_to_save)
    uri_object = URI.parse(uri_to_download)
    
    Net::HTTP::Proxy(@proxy_addr, @proxy_port, @proxy_user, @proxy_pass).start(uri_object.host) do |http|


      resp = fetch(http, uri_object.path)
      if resp.kind_of?(Net::HTTPSuccess)
      
        headers = resp.to_hash
        gzipped = headers['content-encoding'] && headers['content-encoding'][0] == "gzip"
        content = gzipped ? Zlib::GzipReader.new(StringIO.new(resp.body)).read : resp.body 
       
        open(filepath_to_save, "wb") do |file|
          begin
            file.write(content)
          ensure
            file.close()
          end
        end
      end
      return resp
    end
  end

  def fetch(http, uri_str, limit = 10)
    resp = http.get(uri_str)
    if limit == 0
      return Net::HTTPNotFound
    else
      if resp.kind_of?(Net::HTTPRedirection)
        return fetch(http, resp['location'], limit - 1)
      else 
        return resp
      end
    end
  end
end
