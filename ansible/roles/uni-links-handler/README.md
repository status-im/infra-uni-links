# Description

This deploys the [universal-link-handler](https://github.com/status-im/universal-links-handler) which allows use of URLs to:

* Download the Status.im app
* Open specific channels/users/pages in the app

# Configuration

```yaml
uni_links_domain_name: 'join.status.im'
uni_links_cont_image: 'statusteam/universal-links-handler:test'
uni_links_cont_port: 8092
```

# Management

This uses Docker Compose to create the container:
```
admin@node-01.do-ams3.uni-links.misc:/docker/uni-links-handler % docker-compose ps
      Name                     Command               State            Ports          
-------------------------------------------------------------------------------------
uni-links-handler   docker-entrypoint.sh /bin/ ...   Up      127.0.0.1:809
```

The container uses [Watchtower](https://github.com/v2tec/watchtower) to enable automatic updates on tab push.
