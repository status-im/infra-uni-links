# Description

This repo configures the deep linking service for Status.im app.

# Endpoints

https://join.status.im/

By default root redirects to https://status.im/

# Repo Usage

For how to use this repo read the [Infra Repo Usage](https://github.com/status-im/infra-docs/blob/master/articles/infra_repo_usage.md) doc.

# Continuous Integration

Pushes to the `master` branch in the [universal-link-handler](https://github.com/status-im/universal-links-handler) repo trigger [Jenkins builds](https://jenkins.status.im/job/misc/job/universal-links-handler/).

That create new Docker image which is pushed to [Docker Hub](https://hub.docker.com/r/statusteam/universal-links-handler/).

Which is the automatically updated by the [Watchtower](https://github.com/v2tec/watchtower) service.

# High Availability

This setup uses the CloudFlare [Load Balancing](https://support.cloudflare.com/hc/en-us/articles/115000081911-Tutorial-How-to-Set-Up-Load-Balancing-Intelligent-Failover-on-Cloudflare) created via Terraform [`cloud-flare-lb`](modules/cloud-flare-lb) module.
