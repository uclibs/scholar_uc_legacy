## Spring Bean Parameters
(/usr/local/tomcat/webapps/fedora/WEB-INF/applicationContext.xml)

#### Port Numbers
* Sounds like only reason to change is if we are running multiple instances of Fedora on the same box.
* **Leave all ports as they are**
```xml
<bean class="org.fcrepo.server.config.Parameter">
  <constructor-arg type="java.lang.String" value="fedoraServerPort">
    <!-- Defines the port number on which the Fedora server runs; 
         default is 8080. -->
  </constructor-arg>
  <property name="value" value="8080" />
</bean>

<bean class="org.fcrepo.server.config.Parameter">
  <constructor-arg type="java.lang.String" value="fedoraRedirectPort">
    <!-- Defines the redirect port of the Fedora sever; 
         default is 8443. -->
  </constructor-arg>
  <property name="value" value="8443" />
</bean>

<bean class="org.fcrepo.server.config.Parameter">
  <constructor-arg type="java.lang.String" value="fedoraShutdownPort">
    <!-- Defines the port number used to shutdown the Fedora sever; 
         default is 8005. -->
  </constructor-arg>
  <property name="value" value="8005" />
</bean>
```

#### Max Connections
* How many connections might our app make to Fedora at a time?
* **Leave httpClientMaxConnectionsPerHost at 5**
* **Raise httpClientMaxTotalConnections to 50**
```xml
<bean class="org.fcrepo.server.config.Parameter">
  <constructor-arg type="java.lang.String" value="httpClientMaxConnectionsPerHost">
    <!-- Maximum number of Fedora http client connections allowed 
         to a given host. -->
  </constructor-arg>
  <property name="value" value="5" />
</bean>

<bean class="org.fcrepo.server.config.Parameter">
  <constructor-arg type="java.lang.String" value="httpClientMaxTotalConnections">
    <!-- Maximum number of total Fedora http client connections allowed at once. -->
  </constructor-arg>
  <property name="value" value="5" />
</bean>
```

#### Datastream Content Disposition Inline
* Comments suggest disabling this
* Sounds like if we are using XACML policies this needs to be set to false or we will get a 401 response.
```xml
<bean class="org.fcrepo.server.config.Parameter">
  <constructor-arg type="java.lang.String" value="datastreamContentDispositionInlineEnabled">
    <!-- determines if a content-disposition header specifying &quot;inline&quot; and
         a filename is added to the response for the REST API getDatastreamDissemination
         when no query parameter of download=true is specified.  Browser support for
         recognising a filename in case of &quot;inline&quot; content disposition is patchy,
         so you may wish to disable the content disposition header in this case and only
         have it provided when download=true is specified, in which case the content disposition
         of "attachment" will be used; which is generally supported. -->
  </constructor-arg>
  <property name="value" value="true" />
</bean>
```

#### Server Context name
* **Leave as "fedora"**
```xml
<bean class="org.fcrepo.server.config.Parameter">
  <constructor-arg type="java.lang.String" value="fedoraAppServerContext">
    <!-- Defines the context name for the Fedora server within the
         application server. If set to eg "myfedora" the URL for Fedora will result
         in http[s]://fedoraServerHost[:fedoraServerPort]/myfedora. -->
  </constructor-arg>
  <property name="value" value="fedora" />
</bean>
```

#### Client Socket Timeout
* Do we need to raise this value for large objects?
* **Leave as "120" for now** and raise it if we have objects that take over 2 minutes to ingest
```xml
<bean class="org.fcrepo.server.config.Parameter">
  <constructor-arg type="java.lang.String" value="httpClientSocketTimeoutSecs">
    <!-- Number of seconds Fedora http client will wait for data coming across an
         established http connection. -->
  </constructor-arg>
  <property name="value" value="120" />
</bean>
```

#### Server URL
* Change to the URL for each Fedora server?
* **scholar-devdb.uc.edu**
* **scholar-qadb.uc.edu**
* **scholar-db.uc.edu**
```xml
<bean class="org.fcrepo.server.config.Parameter">
  <constructor-arg type="java.lang.String" value="fedoraServerHost">
    <!-- Defines the host name for the Fedora server, as seen from the
         outside world. -->
  </constructor-arg>
  <property name="value" value="localhost" />
</bean>
```

#### Client user Agent
* **Leave as "Fedora"**
```xml
<bean class="org.fcrepo.server.config.Parameter">
  <constructor-arg type="java.lang.String" value="httpClientUserAgent">
    <!-- The value to be set for the User-Agent HTTP request header. -->
  </constructor-arg>
  <property name="value" value="Fedora" />
</bean>
 ```

#### Repository Name
* Change to name of our repository?
* Use "**Scholar @ UC**"?  
* "**Scholar @ UC QA**" and "**Scholar @ UC Dev**"?
```xml
<bean class="org.fcrepo.server.config.Parameter">
  <constructor-arg type="java.lang.String" value="repositoryName">
    <!-- Defines a human readable name for the Fedora server; default is
         Fedora Repository. -->
  </constructor-arg>
  <property name="value" value="Fedora Repository" />
</bean>
```

#### Admin Emails
* Include **Linda, Thomas, and Glen** for now
```xml
<bean class="org.fcrepo.server.config.Parameter">
  <constructor-arg type="java.lang.String" value="adminEmailList">
    <!-- Defines one or more email addresses for server administrators;
         list is space delimited. -->
  </constructor-arg>
  <property name="value" value="bob@example.org sally@example.org" />
</bean>
```

## Legacy Parameters
(/usr/local/fedora/server/config/fedora.fcfg)

#### Namespace
* Use '**scholar**'
* Note: this is overridden by the app in config/initializers/sufia.rb
```xml
<param name="pidNamespace" value="changeme">
  <comment>This is the namespace id for pids of newly-created objects.  This should be unique for a repository. It can be from 1 to 17 characters, and may only contain A-Z, a-z, 0-9, ., or -; (dash).</comment>
</param>
```

#### Checksums
* Do we want to auto-generate checksums?  Yes
* Do the checksums ever get re-generated?
* Nathan suggests **SHA-256**.  This is was AP Trust uses
```xml
<param name="autoChecksum" value="false">
  <comment>Controls whether a checksum is automatically computed for every datastream as the datastream is added to the repository. This will allow the integrity of datastream contents to be periodically checked to insure the object is not corrupted.</comment>
</param>

<param name="checksumAlgorithm" value="MD5">
  <comment>Specifies which checksumming algorithm is to be used when automatically computing checksums as specified by the above parameter. Valid values are: MD5  SHA-1  SHA-256  SHA-384  SHA-512.</comment>
</param>
```

#### Max Results
* Might we ever have more than 100 records to return?
* **Leave as "100"** until we see reason to change this.
```xml
<param name="maxResults" value="100">
  <comment>(required, must be > 0) The maximum number of records to return as the result of a search. Even if a client requests more results at a time, this is the cutoff value.</comment>
</param>
```

#### XACML Stuff
* Default policies at /usr/local/fedora/data/fedora-xacml-policies/repository-policies/default
* Place non-default policies outside the FEDORA_HOME tree
* Store custom XACML policies in a Git repo?
* Look at deny-apim-if-not-localhost.xml
* Store our soft-delete policies here
* Resources
    * [Fedora Authorization with XACML Policy Enforcement](http://fedora-commons.org/documentation/3.0/userdocs/server/security/AuthorizationXACML.htm)
    * [Fedora XACML Policy Writing Guide](http://fedora-commons.org/documentation/3.0/userdocs/server/security/XACMLPolicyGuide.htm)
    * [Securing Your Fedora Repository](http://fedora-commons.org/documentation/3.0/userdocs/server/security/securingrepo.html)

```xml
<module role="org.fcrepo.server.security.Authorization" class="org.fcrepo.server.security.DefaultAuthorization">

  <comment>Builds and manages Fedora's authorization structure.</comment>

  <param name="REPOSITORY-POLICY-GUITOOL-POLICIES-DIRECTORY" value="data/fedora-xacml-policies/repository-policies-generated-by-policyguitool" isFilePath="true">
    <comment>This parameter is for future use.</comment>
  </param>

  <param name="POLICY-SCHEMA-PATH" value="xsd/cs-xacml-schema-policy-01.xsd"/>

  <param name="ENFORCE-MODE" value="permit-all-requests"/>

  <param name="VALIDATE-OBJECT-POLICIES-FROM-DATASTREAM" value="false"/>

  <param name="XACML-COMBINING-ALGORITHM" value="com.sun.xacml.combine.OrderedDenyOverridesPolicyAlg"/>

  <param name="VALIDATE-OBJECT-POLICIES-FROM-FILE" value="false"/>

  <param name="VALIDATE-REPOSITORY-POLICIES" value="true"/>

  <param name="REPOSITORY-POLICIES-DIRECTORY" value="data/fedora-xacml-policies/repository-policies" isFilePath="true"/>

</module>
```

#### OAI Harvesters
* Do we want to allow OAI harvesters?  Yes, eventually.
* **Leave this unconfigured for now**.
```xml
<module role="org.fcrepo.oai.OAIProvider" class="org.fcrepo.server.oai.FedoraOAIProviderModule">

  <comment>Description: Exposes the repository for OAI harvesters.</comment>

  <param name="maxRecords" value="100"/>

  <param name="friends" value="http://arXiv.org/oai2 http://memory.loc.gov/cgi-bin/oai2_0"/>

  <param name="adminEmails" value="oai-admin@example.org bob@example.org"/>

  <param name="repositoryDomainName" value="example.org"/>

  <param name="maxHeaders" value="100"/>

  <param name="repositoryName" value="Your Fedora Repository Name Here"/>

</module>
```

#### MySQL stuff
* **Changes have already been made**.
```xml
<datastore id="localMySQLPool">
  <comment>MySQL database on localhost with db name of fedora3. Each connection pool instance has several configuration parameter that can be used to tune the options for the connection pool. It is recommended that you not change the default values unless you are trying to address a specific performance issue. For additional information regarding connection pool options, refer to the Apache Commons Pool API documentation at http://jakarta.apache.org/commons/pool/apidocs/index.html.</comment>

  <param name="dbUsername" value="fedoraAdmin">
    <comment>The database user name.</comment>
  </param>

  <param name="dbPassword" value="***hidden***">
    <comment>The database password.</comment>
  </param>

  <param name="jdbcURL" value="jdbc:mysql://ucdbqil6.private/fedora3?useUnicode=true&amp;amp;characterEncoding=UTF-8&amp;amp;autoReconnect=true">
    <comment>The JDBC connection URL.</comment>
  </param>

</datastore>
```