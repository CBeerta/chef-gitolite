name             "gitolite"
maintainer       "Claus Beerta"
maintainer_email "claus@beerta.de"
license          "Apache 2.0"
description      "Installs gitolite"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.1.0"

depends 'git'

recipe "gitolite", "Install Gitolite"

attribute "gitolite", 
	:display_name => "Gitolite Hash",
	:description => "Hash of Gitolite attributes",
	:type => "hash"

attribute "gitolite/ssh_admin_pubkey",
	:display_name => "Gitolite Admin SSH Public Key",
	:description => "SSH Public Key for Admin User. Leave nil to create a new KeyPair",
	:default => nil

attribute "gitolite/ssh_admin_name",
	:display_name => "Name of the Admin User",
	:description => "Name of the Admin User to use for the Public Key. No Spaces.",
	:default => "GitoliteAdmin"

attribute "gitolite/home_dir",
	:display_name => "Home Directory for gitolite",
	:description => "Where to Create the Home Directory, and store all Repositories",
	:default => "/var/gitolite"

attribute "gitolite/repository_url",
	:display_name => "Repo Url to Gitolite",
	:description => "URL to the GIT Repository for Gitolite",
	:default => "git://github.com/sitaramc/gitolite.git"

