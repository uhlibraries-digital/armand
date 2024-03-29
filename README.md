# Armand

[![Maintainability](https://api.codeclimate.com/v1/badges/337265c2bcfccf23da0a/maintainability)](https://codeclimate.com/github/uhlibraries-digital/armand/maintainability)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://raw.githubusercontent.com/uhlibraries-digital/armand/master/LICENSE.txt)

Armand is a digital repository based on [Hyrax](https://github.com/samvera/hyrax)

## Manual Installation

1. Cone repository
2. Install: `bundle install`
3. Setup databases: `bundle exec rake db:setup`
4. Create default Admin Set: `rake hyrax:default_admin_set:create`

## Docker

Intial setup. Run the command below to get Armand setup for the first time in docker
```
docker-compose run --rm -v $PWD/solr/config:/config solr bash -c "precreate-core armand-development /config"
docker-compose run --rm app rails db:migrate
docker-compose run --rm app rake hyrax:default_admin_set:create
```

Run Armand
```
docker-compose up app
```
### Authentication
This instance of Avalon is setup to use SAML authentication. The development environment comes with a IDP [Fake AzureAD](https://hub.docker.com/r/seanlw/fake-azuread) with 2 users available. (NOTE: Fake AzureAD is not to be used in a production environment)

Administrator Account:
Username|Password
---|---
smithj|password

Basic User Account:
Username|Password
---|---
doej|password


## Dependencies

These dependencies are required to run both Armand and the Hyrax stack.

1. [Solr](http://lucene.apache.org/solr/) >= 5.x
2. [Fedora Commons](http://www.fedora-commons.org/) >=4.5.1
3. [PostgreSQL](https://www.postgresql.org/)
4. [Redis](http://redis.io/)
5. [ImageMagick](http://www.imagemagick.org/) with JPEG-2000 support
6. [FITS](http://projects.iq.harvard.edu/fits/downloads) >= 1.0.x
7. [LibreOffice](https://www.libreoffice.org/)
8. ffmpeg

## License

**[Apache-2.0](LICENSE.txt)**