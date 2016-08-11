**Concerns when working on Curate and Sufia 7:**

---

`/tmp/minter-state` file - deleting it whenever you are switching from Sufia development to Curate (app or gem) development. It doesn't look like it's a yaml file anymore, and the libraries in Curate are expecting it to be.

---

Getting specs running for Sufia 7

```
(install phantomjs first)

git clone git@github.com:projecthydra/sufia.git

cd sufia

git checkout tags/v7.0.0.beta4

rvm use 2.3.1

gem install rails -v 4.2.6

bundle install

# edit tasks/noid.rake (edit file to use the path to noid_tasks.rake on your machine) - to get gem path, use:
# bundle show active_fedora-noid
-load "#{af_noid.gem_dir}/lib/tasks/noid_tasks.rake"
+load "PATH_TO_GEM/lib/tasks/noid_tasks.rake"

rake engine_cart:generate

# the wrappers for solr and fedora as well as redis need to be run in separate terminals. Open three additional windows.

#start redis in any terminal, working directory doesn't matter
redis-server

cd .internal_test_app # in a new terminal

solr_wrapper -d solr/config/ --collection_name hydra-test -p 8985

#navigate to sufia's parent directory (i.e. workspace/) in a new terminal and run:

fcrepo_wrapper -p 8986

#in your final terminal change to sufia's directory

cd sufia

#run specs

rake spec
```

---