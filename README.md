Description
===========

Installs gitolite from git.

If no SSH Public Key is specified, a new Keypair is generated, that can be found in gitolite's Home Directory.

Attributes
==========

* `node[:gitolite][:ssh_admin_pubkey]` - SSH Public Key for Admin Account
* `node[:gitolite][:ssh_admin_name]` - Name of the Admin User
* `node[:gitolite][:home_dir]` - Home directory for gitolite and the Repositories
* `node[:gitolite][:repository_url]` - Url to Clone gitolite from

License and Authors
===================

Author:: Claus Beerta <claus@beerta.de>
Author:: David Ruan <ruanwz@gmail.com>

Copyright:: 2013, Claus Beerta <claus@beerta.de>
Copyright:: 2011, David Ruan <ruanwz@gmail.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
