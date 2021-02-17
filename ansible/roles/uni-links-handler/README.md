# Description

This deploys the [universal-link-handler](https://github.com/status-im/universal-links-handler) which allows use of URLs to:

* Download the Status.im app
* Open specific channels/users/pages in the app

# Details

Thid deploys a docker container named `uni-links-handler` for handling redirecting.
The container uses [Watchtower](https://github.com/v2tec/watchtower) to enable automatic updates on tab push.

Pushes to the `master` branch of the [universal-link-handler](https://github.com/status-im/universal-links-handler) repo trigger Jenkins builds to create new docker image:
https://jenkins.status.im/job/misc/job/universal-links-handler/

Which and uploads them to Docker Hub:
https://hub.docker.com/r/statusteam/universal-links-handler/

Which is the automatically updated by the [watchtower](https://github.com/v2tec/watchtower) container.

# High Availability

This setup uses the CloudFlare [Load Balancing](https://support.cloudflare.com/hc/en-us/articles/115000081911-Tutorial-How-to-Set-Up-Load-Balancing-Intelligent-Failover-on-Cloudflare) created via Terraform in [`main.tf`](main.tf).
