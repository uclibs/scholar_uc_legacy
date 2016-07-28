I've identified 2 ways of making this migration.

1. Fedora-Migrate https://github.com/projecthydra-labs/fedora-migrate. This is a gem that you add to the new working Fedora 4 application. You have to have all the same models you want to migrate defined in the new app, and a config/fedora3.yml file that points to your Fedora 3 instance. Then you need to write a rake task to do the actual migration (example in the link). This seems like a more difficult approach than the other option, although it seems more configurable.

2. Migration-utils: https://github.com/fcrepo4-exts/migration-utils. This is a utility that uses FOXML data to do the migration. This seems like a much easier approach. There is a config file you edit to reflect our specific setup, and then just run the utility. 


