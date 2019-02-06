# Armand

Armand is digital repository built based on [Hyrax](https://github.com/samvera/hyrax)

## Installation

1. Cone repository
2. Install: `bundle install`
3. Setup databases: `bundle exec rake db:setup`
4. Create default Admin Set: `rake hyrax:default_admin_set:create`

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

**[Apache-2.0](LICENSE)**