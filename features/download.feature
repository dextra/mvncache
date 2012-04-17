Feature: Download files
  In order to cache files
  As a cache manager
  I want to download files

Scenario: URL is valid
  Given an URL
  When URL is "http://teste:teste@repo.pyrata.org/release/maven2/org/mycontainer/mycontainer-kernel/maven-metadata.xml"
  Then the URL is valid

Scenario: URL is invalid
  Given an URL
  When URL is "http://teste@teste:repo.pyrata.org/release/maven2/org/mycontainer/mycontainer-kernel/maven-metadata.xml"
  Then the URL is invalid

