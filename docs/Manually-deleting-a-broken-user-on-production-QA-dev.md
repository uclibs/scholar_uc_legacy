Scholar stores user information in both the MySQL database and Fedora.  Sometimes the user gets partially created in just MySQL and not Fedora.  This makes it impossible to sign up the user properly.  Use the steps below to delete the user from MySQL

1. Ssh to one of the production/QA/dev web servers (e.g. libhydpwl1 or libhydpwl2)

1. Look for the MySQL hostname, username, and password in the `/srv/apps/curate_uc/config/database.yml` file

1. At the command line, connect to MySQL using the values you got from database.yml<br/>`mysql -h <hostname> -u <username> --password=<password>`

1. Connect to the curate database<br />`connect curate`

1. Delete the user from the users table (replace "address" with the user's email address)<br />`delete from users where email = 'address' limit 1;`

1. Exit MySQL<br />`exit`


