<h1>Modifying Fedora Records</h1>
1.  Configure browser to use secure tunnel.
1.  Access http://SERVER/fedora/admin.
1.  Login with http: and no port (80).

<h1>Restoring a deleted Fedora Record</h1>
1.  Login into Fedora server.
1.  Navigate to /usr/local/fedora/data.
1.  grep -r "title" . and copy work_pid.
1.  grep -r "work_pid" . to find all of the attached files.
1.  Configure browser to use secure tunnel.
1.  Access http://SERVER/fedora/admin.
1.  Login with http: and no port.
1.  Find deleted work object by pid.
1.  Change State from D to A.
1.  Find deleted attached files by pid.
2.  Export content to local environment.
1.  Browse to object in application.  http://scholar.uc.edu/work_pid
1.  Edit object and save to re-index in SOLR.
1.  Re-attach files directly to work.

<h1>Configure browser to use secure tunnel</h1>
With changes made to the XACML policies, we can access the Fedora GUI by creating a SOCKS proxy using an ssh tunnel. Until we get a wiki page created, the details are below.

`ssh -D 9999 -C username@proxy.libraries.uc.edu`

After entering your password, the tunnel will be in place. The next step is to configure Firefox to use a SOCKS proxy:

Firefox> Edit> Preferences> Advanced tab> Network tab> Settings button.
* Select Manual proxy configuration
* SOCKS Host: localhost Port: 9999
* SOCKS v5
* No Proxy for: localhost, 127.0.0.1

Any site you visit in Firefox will now first pass through Larry. So other website will see your traffic as if Larry is the source. You will then be able to access the Fedora GUI for dev, QA, and production.

To turn off the proxy, switch to "No proxy" in Firefox's Network settings and then log out of your ssh session to Proxy.
