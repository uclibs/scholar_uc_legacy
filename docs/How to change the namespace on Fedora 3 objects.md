1. Backup Fedora Repository data folders
	1. Location of data:  /fedora/default/data

1. Remove Fedora Policies
	1. fedora.fcfg
		1.  ```<param name="ENFORCE-MODE" value="deny-all-requests"/>```
      1. enforce-policies - enable XACML enforcement to determine whether a request is permitted or denied
      1. permit-all-requests – disable XACML enforcement; PERMIT every request by default
      1. deny-all-requests -  disable XACML enforcement; DENY every request by default

1. Export all of the FOXML files for all of the objects in the Fedora 3 repository
      1. ./fedora-export.sh localhost:8080 fedoraAdmin fedoraAdmin DMO info:fedora/fedora-system:FOXML-1.1 archive /tmp/fedoradump http	
1. Rename all of the files to the new namespace
      1. find . -name *old_namespace* | sed -e "p;s/old_namespace/new_namespace/" | xargs -n2 mv

1. Run a Find and Replace Script on all of the FOXML files
	1. Generate change.sh
		1. grep -rl old_namespace * > change.sh

	1. Edit change.sh to include sed
		1. sed -i.bak 's/old_namespace/new_namespace/g'  ^
	
	1. Execute change.sh

	1. Remove .bak files
	
1.  Run a Find and Replace on all of the HEX content in the FOXML files
  	1. Copy content out of data stream.
	  1. https://www.base64decode.org/
	1. Replace old_namespace string with new_namespace string
	  1. https://www.base64encode.org/
	1. Copy back into FOXML file

1.  Delete Checksum DIGEST from FOXML files
	1.  ```<foxml:contentDigest TYPE="SHA-256" DIGEST="d16a3953a577d8e27c4aa94f6f98d85c3dbfe0a60652498e637708ddbfe2c01a"/>```

1.  Ingest all of the FOXML files for all of the new objects in the Fedora 3 repository
	1. ./fedora-ingest.sh f /tmp/fedoradump/sufia_rx913q47f.xml.xmlinfo:fedora/fedora-system:FOXML-1.1 localhost:8080 fedoraAdmin fedoraAdmin http

1.  Delete all of objects with the old namespace
	1. find . -type f -name "*old_namespace" -exec rm -rf {} \;

1.  Rebuild Fedora
	1. /fedora/data/server/bin/fedora-rebuild.sh
		1. Resource Index
		1. MySQL
	1. Tomcat must be stopped.
	If you are using jetty for fedora you will have problems with CATALINA_HOME.  There is a entry in hydra-tech about this: https://groups.google.com/forum/#!searchin/hydra-tech/let$20FEDORA_HOME$20point$20to$20the$20Fedora$20installation$20that$20was$20created$20from$20the$20installer/hydra-tech/DSEEu-EEHNQ/lziFZZpBi4QJ

1.  Rake SOLR: Reindex
	1. rake solr:reindex inside of your application

1.  Re-pply Fedora Policies
	1. fedora.fcfg
		1.  ```<param name="ENFORCE-MODE" value="enforce-policies"/>```

1.  Modify Application Code to use new namespace.
	1. config/initializers/sufia.rb
