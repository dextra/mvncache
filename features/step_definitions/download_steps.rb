Given /^an URL$/ do
end

When /^URL is "([^"]*)"$/ do |url|
  @download = Download.new(url)
end

Then /^the URL is valid$/ do
  @download.valid_url?.should == true
end

Then /^the URL is invalid$/ do
  @download.valid_url?.should == false
end

