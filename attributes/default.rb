#
# Setup Admin User 
#
# If ssh_admin_pubkey is left at nil, a keypair will be generated
default[:gitolite][:ssh_admin_pubkey] = nil
default[:gitolite][:ssh_admin_name] = "GitoliteAdmin"

# 
# Directory to Store repos in
#
default[:gitolite][:home_dir] = "/var/gitolite"

#
# Url to the source for gitolite
#
default[:gitolite][:repository_url] = "git://github.com/sitaramc/gitolite.git"
