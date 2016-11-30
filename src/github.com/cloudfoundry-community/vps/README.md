**BOSH VPS release**
-------------

VPS(Virtual guests Pooling Server) provides APIs to utilize virtual guests pooling on SoftLayer. This is a BOSH release for VPS.

**Releases and stemcells**
-------------
Except VPS release,  following releases are also required.

- [postgres 9.4](http://bosh.io/releases/github.com/cloudfoundry/postgres-release) 
- [bosh-softlayer-cpi](http://bosh.io/releases/github.com/cloudfoundry-incubator/bosh-softlayer-cpi-release) 

SoftLayer light stemcell is needed for deployment and can be found in [bosh.io](http://bosh.io/)

**Bootstrap a VPS on SoftLayer**
-------------
You can use bosh-init from BOSH community to bootstrap a VPS on SoftLayer.

- To install bosh-init, please refer to [install-bosh-init](http://bosh.io/docs/install-bosh-init.html) and its usage can be found in [using-bosh-init](http://bosh.io/docs/using-bosh-init.html).
> **Note:**
>  Please make sure the machine installed bosh-init can access SoftLayer private network and you can enable SoftLayer VPN if it is outside of SoftLayer data center. This is because it need to communicate with the target VM over SoftLayer private network to accomplish a successful deployment.

- Download releases and stemcells. Resource link are described in section [Releases and stemcells]
    - VPS release
    - postgres release
    - bosh-softlayer-cpi release
    - SoftLayer light stemcell
- Prepare a deployment manifest
You can find a deployment manifest example under docs named `vps-init-example.yml` and please replace release, stemcell, resource and credential information accordingly. Here are some key fields need to specify.
```
jobs:
- name: vps
  instances: 1

  templates:
  - {name: postgres-9.4, release: postgres}
  - {name: vps, release: vps}

  resource_pool: vms

  networks:
  - name: default

  properties:
    postgres: &20585760
      user: postgres
      password: postgres
      host: 127.0.0.1
      database: bosh
      adapter: postgres
    vps:
      host: 127.0.0.1
      port: 8889
      log_level: debug
      sql:
        db_username: postgres
        db_password: postgres
        db_host: 127.0.0.1
        db_port: 5432
        db_schema: bosh
        db_driver: postgres

```
- Kick-off deployment

```
bosh-init deploy <your-manifest.yml>
```

- After deployment completes, you can login the environment and take a check. Run `monit summary`, normally if everything works well you can get an output as below.
```
~# monit summary
The Monit daemon 5.2.5 uptime: 15d 9h 41m

Process 'vps'               running
Process 'postgres'          running
System 'system_localhost'   running
```
> **Note:**
> If any job is not running, run `monit restart` <job-name> to restart it. If this doesn't work out, you can check logs under /var/vcap/sys/log and do further investigation.

- To fully enable virtual guest pooling on SoftLayer, except deploying a VPS, you also need to make director to connect to VPS and enable pooling feature. Please refer to guide on [bosh-softlayer-cpi-release](https://github.com/cloudfoundry-incubator/bosh-softlayer-cpi-release).


