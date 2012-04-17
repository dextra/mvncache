require 'spec_helper'
require 'fileutils'

module Cache
  describe CacheManager do

    let(:cache_dir) { cache_dir = "/tmp/cache_maven" }
    let(:manager) { manager = CacheManager.new(cache_dir, '172.16.129.1', 3128) }
    let(:url) { url = "http://repo.pyrata.org/release/maven2/org/mycontainer/mycontainer-kernel/maven-metadata.xml" }
    
    describe ".generate_dirname" do
      it "generate directory name from url" do
        manager.generate_dirname(url).should == 'repo.pyrata.org/release/maven2/org/mycontainer/mycontainer-kernel'
      end
    end

    describe ".generate_cache_dirname" do
      it "generate cache directory name from url" do
        manager.generate_cache_dirname(url).should == File.join(cache_dir, 'repo.pyrata.org/release/maven2/org/mycontainer/mycontainer-kernel')
      end
    end

    describe ".ensure_cache_dir_exists" do
      it "ensures that cache directory exists" do
        directory = manager.generate_cache_dirname(url)
        manager.ensure_dir_exists(directory) == true
        FileUtils.rm_rf(File.join(cache_dir, manager.generate_dirname(url).split('/')[0]))
      end
    end

    describe ".cache" do
      it "caches file from a given url when it doesn't exists in the cache" do
        FileUtils.rm_rf(File.join(cache_dir, manager.generate_dirname(url).split('/')[0]))
        
        manager.cache(url)
        manager.downloaded_file?.should == true

        File.exists?("/tmp/cache_maven/repo.pyrata.org/release/maven2/org/mycontainer/mycontainer-kernel/maven-metadata.xml").should == true
        
        FileUtils.rm_rf(File.join(cache_dir, manager.generate_dirname(url).split('/')[0]))
      end
    end

    describe ".cache" do
      it "does not download file from a given url when it exists in the cache" do

        # Downloads file the first time if necessary
        if not File.exists?("/tmp/cache_maven/repo.pyrata.org/release/maven2/org/mycontainer/mycontainer-kernel/maven-metadata.xml")
          manager.cache(url)
        end
        
        # No download should be made here
        manager.cache(url)
        manager.downloaded_file?.should == false
        
        File.exists?("/tmp/cache_maven/repo.pyrata.org/release/maven2/org/mycontainer/mycontainer-kernel/maven-metadata.xml").should == true

        FileUtils.rm_rf(File.join(cache_dir, manager.generate_dirname(url).split('/')[0]))
      end
    end

    describe '.extract_requested_file_url' do
      it 'checks wheter file URL is correctly extracted from the full URL' do
        CacheManager.extract_requested_file_url('http://localhost:3000/noprotocolspecified').should == nil
        CacheManager.extract_requested_file_url('http://localhost:3000/http://example.com').should == 'http://example.com'
        CacheManager.extract_requested_file_url('http://localhost:3000/https://example.com').should == 'https://example.com'
        CacheManager.extract_requested_file_url('http://localhost:3000/svn+ssh://example.com/file.txt').should == 'svn+ssh://example.com/file.txt'
        CacheManager.extract_requested_file_url('http://localhost:3000/http://www.w3schools.com/xml/note.xml').should == 'http://www.w3schools.com/xml/note.xml'
        CacheManager.extract_requested_file_url('http://localhost:3000/').should == nil 
      end
    end
  end
end
