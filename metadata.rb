name 'centos67_nginx'
maintainer 'Niya'
maintainer_email 'github72@gmail.com'
license 'all_rights'
description 'Installs/Configures centos67_nginx'
long_description 'Installs/Configures centos67_nginx'
version '0.1.0'

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Issues` link
# issues_url 'https://github.com/<insert_org_here>/centos67_nginx/issues' if respond_to?(:issues_url)

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Source` link
# source_url 'https://github.com/<insert_org_here>/centos67_nginx' if respond_to?(:source_url)

depends 'yum', '~> 4.1.0'
depends 'nginx', '~>2.7.6'


