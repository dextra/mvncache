require 'spec_helper'

module Cache
  describe URL do
    describe ".valid" do
      it "requests a valid url" do
        url = URL.new("http://teste:teste@repo.pyrata.org/release/maven2/org/mycontainer/mycontainer-kernel/maven-metadata.xml")
        url.valid?.should == true
      end

      it "requests an invalid url (mispelled)" do
        url = URL.new("http://teste@teste:repo.pyrata.org/release/maven2/org/mycontainer/mycontainer-kernel/maven-metadata.xml")
        url.valid?.should == false
      end

      it "requests an invalid url (other protocol then http/https)" do
        url = URL.new("ssh://teste@teste:repo.pyrata.org/release/maven2/org/mycontainer/mycontainer-kernel/maven-metadata.xml")
        url.valid?.should == false
      end
    end

    describe ".filename" do
      it "extract filename from url" do
        url = URL.new("http://teste:teste@repo.pyrata.org/release/maven2/org/mycontainer/mycontainer-kernel/maven-metadata.xml")
        url.filename.should == "maven-metadata.xml"
      end
    end
  end
end