require 'spec_helper'
require "#{File.dirname(__FILE__)}/../../config/environment"

module Cache
  describe Download do
    let(:download) {
      download = Download.new(PROXY_HOST, PROXY_PORT, PROXY_USER, PROXY_PASS)
    }
    
    describe '.run pyrata.org' do
      it 'downloads and caches file maven-metadata.xml' do
        download.run('http://repo.pyrata.org/release/maven2/org/mycontainer/mycontainer-kernel/maven-metadata.xml', '/tmp/maven-metadata.xml')
        File.exist?('/tmp/maven-metadata.xml').should == true
        File.delete('/tmp/maven-metadata.xml')
      end
    end
    
    describe '.run w3schools.com' do
      it 'downloads and caches file note.xml' do
        download.run('http://www.w3schools.com/xml/note.xml', '/tmp/note.xml')
        File.exist?('/tmp/note.xml').should == true
        File.delete('/tmp/note.xml')
      end
    end

    describe '.run sbmet.org.br' do
      it 'downloads and caches gif file' do
        download.run('http://sbmet.org.br/ecomac/img/txt_icon.gif', '/tmp/txt_icon.gif')
        File.exist?('/tmp/txt_icon.gif').should == true
        File.delete('/tmp/txt_icon.gif')
      end
    end

  end
end