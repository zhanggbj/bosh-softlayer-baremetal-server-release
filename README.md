	
**BOSH SoftLayer Pool Server Release**
-------------

BOSH SoftLayer pool server provides APIs to utilize virtual guests pooling on SoftLayer. This is a BOSH release for it.

**Releases and stemcells**
-------------
The following releases are dependencies.

- [postgres](http://bosh.io/releases/github.com/cloudfoundry/postgres-release) 
- [bosh-softlayer-cpi](http://bosh.io/releases/github.com/cloudfoundry-incubator/bosh-softlayer-cpi-release) 

SoftLayer light stemcell is needed for deployment and can be found the [latest version](https://bosh.io/d/stemcells/bosh-softlayer-xen-ubuntu-trusty-go_agent) on bosh.io.

**Bootstrap on SoftLayer**
-------------
You can use bosh-init from BOSH community to bootstrap a pool server on SoftLayer. 

> **Warning:** To fully enable virtual guest pooling on SoftLayer, except deploying a pool server, you also need to make director to connect to it and enable pooling feature. Please refer to guide on [bosh-softlayer-cpi-release](https://github.com/cloudfoundry-incubator/bosh-softlayer-cpi-release).


> **Note:** 
> In bosh CLI v2, bosh-init is deprecated and use `bosh create-env` instead.

- To install bosh-init, please refer to [install-bosh-init](http://bosh.io/docs/install-bosh-init.html) and its usage can be found in [using-bosh-init](http://bosh.io/docs/using-bosh-init.html).
> **Note:**
>  Please make sure the machine installed bosh-init can access SoftLayer private network and you can enable SoftLayer VPN if it is outside of SoftLayer data center. This is because it need to communicate with the target VM over SoftLayer private network to accomplish a successful deployment.

- Prepare a deployment manifest

You can find a deployment manifest example under docs named [vps-init-example.yml](https://github.com/cloudfoundry-community/bosh-softlayer-pool-server-release/tree/develop/docs) which can deploy a virtual guest pooling server and please replace release, stemcell, resource and credential information accordingly.
> **Note:**
>  For releases and stemcells, please either use url like the example manifest does or download them to your local machine and specify its location.
>  
>  - bosh-softlayer-pool-server-release
>  - postgres-release
>  - bosh-softlayer-cpi-release
>  - SoftLayer light stemcell

Here is an example for key properties of jobs.
```
jobs:
- name: vps
  instances: 1

  templates:
  - {name: postgres, release: postgres}
  - {name: vps, release: bosh-softlayer-pool-server}

  resource_pool: vms
  persistent_disk_pool: disks

  networks:
  - name: default

  properties:
    databases:
      roles:
      - name: postgres
      password: postgres
      address: 127.0.0.1
      port: 5432
      databases:
      - name: bosh
    vps:
      host: 0.0.0.0
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
- Kick-off deployment. You will got an output during deploying as below.

```
bosh-init deploy <your-manifest.yml>

Started validating
  Validating release 'postgres'... Finished (00:00:00)
  Validating release 'bosh-softlayer-pool-server'... Finished (00:00:03)
  Validating release 'bosh-softlayer-cpi'... Finished (00:00:01)
  Validating cpi release... Finished (00:00:00)
  Validating deployment manifest... Finished (00:00:00)
  Validating stemcell... Finished (00:00:00)
Finished validating (00:00:05)

Started installing CPI
  Compiling package 'golang_1.7.1/3b839fd4af8adab60ce6ecbba8c80fcf48331f72'... Finished (00:00:21)
  Compiling package 'bosh_softlayer_cpi/d3e6c9bb05e20dcaa36f91e090272066456f1775'... Finished (00:00:12)
  Installing packages... Finished (00:00:03)
  Rendering job templates... Finished (00:00:00)
  Installing job 'softlayer_cpi'... Finished (00:00:00)
Finished installing CPI (00:00:37)

Starting registry... Finished (00:00:00)
Uploading stemcell 'light-bosh-stemcell-3169.1-softlayer-esxi-ubuntu-trusty-go_agent/3169.1'... Finished (00:00:00)

Started deploying
  Creating VM for instance 'vps/0' from stemcell '1147241'... Finished (00:05:08)
  Waiting for the agent on VM '26597105' to be ready... Finished (00:00:05)
  Rendering job templates... Finished (00:00:00)
  Compiling package 'golang_1.7/2f2e9cb9f08e6517c7b588ad68d556e9e4a792e8'... Finished (00:00:23)
  Compiling package 'postgres-common/368d38d49a3cc717559ebcdb2390b68882a85053'... Finished (00:00:01)
  Compiling package 'postgres-9.4.9/8a20abd4ccec4d356cc29169d38be561d99bc1ff'... Finished (00:04:55)
  Compiling package 'vps/70086910ffc53a19daa0e4b922af642c8d74a080'... Finished (00:00:13)
  Updating instance 'vps/0'... Finished (00:00:15)
  Waiting for instance 'vps/0' to be running... Finished (00:00:39)
  Running the post-start scripts 'vps/0'... Finished (00:00:00)
Finished deploying (00:11:43)

Stopping registry... Finished (00:00:00)
Cleaning up rendered CPI jobs... Finished (00:00:00)

```