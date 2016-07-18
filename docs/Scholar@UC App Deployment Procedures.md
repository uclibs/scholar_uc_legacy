### Dev server
1. Visit https://eai.uc.edu/bamboo and log in
1. Click on the **Ruby-Curate** plan.
1. Select the **develop** branch from the drop-down.  You should see a list of the most recent builds
1. Click on **Deployments**
1. Click the cloud icon in the **Actions** column on the far right of the page.
1. Click **Create new release** and choose **develop** for the Plan Branch and select the build you want to use.
1. Click the **Start Deployment** button
1. When the deployment is finished, check the log for errors.
1. Visit https://scholar-dev.uc.edu to verify the site is up.

### QA server
1. Review Risk Matrix : https://github.com/uclibs/scholar_uc/issues/203
1. Visit https://eai.uc.edu/bamboo and log in
1. Click on the **Ruby-Curate** plan.
1. Select the **release** branch from the drop-down. You should see a list of the most recent builds
1. Click on **Deployments**
1. Click the cloud icon in the **Actions** column on the far right of the page.
1. Click **Create new release** and choose **release** for the Plan Branch and select the build you want to use.
1. Click the **Start Deployment** button
1. When the deployment is finished, check the log for errors.
1. Visit https://scholar-qa.uc.edu to verify the site is up.
1. If a Hailstorm scan against QA is needed, set date for request of Hailstorm scan to be the date of deploy to QA.
2. Visit Hailstorm and request scan: https://uc.teamdynamix.com/TDClient/Requests/ServiceDet?ID=5368
1. If a Hailstorm scan will take place, await results and determine if remediation is necessary before moving on to Production server.

### Production server

1. Visit UCIT Change Request:  https://webapps2.uc.edu/ucit/changemgmt/ChangeManagementForm.aspx
1. Wait for request approval.  Once approval has been received, communicate date and time to stake holders.
1. Visit https://eai.uc.edu/bamboo and log in
1. Click on the **Ruby-Curate** plan.
1. Select the **master** branch from the drop-down. You should see a list of the most recent builds
1. Click on **Deployments**
1. Click the cloud icon in the **Actions** column on the far right of the page.
1. Click **Create new release** and choose **master** for the Plan Branch and select the build you want to use.
1. Click the **Start Deployment** button
1. When the deployment is finished, check the log for errors.
1. Visit https://scholar.uc.edu to verify the site is up.