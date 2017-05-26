# beam_deployer
Helpers scripts for automatic beam swapping on remote hosts

## Usage

Scripts are standalone and rely on ./ssh/config of:
* a-demo-onedata-cyfronet-provider
* a-demo-onedata-lab-provider
* a-demo-onedata-infn-provider
* a-demo-onedata-infn-client

### Hotswapping oneclient 

The client will be mounted on a-demo-onedata-cyfronet-provider and a-demo-onedata-infn-client remote hosts in /mnt/oneclient_new (when remounting - do not stay in this dir)

```bash
./compile_and_deploy_oneclient_to_demo.sh ~/one_projects/oneclient-rc14 MDAxNWxvY2F00aW9uIG9uZXpvbmUKMDAzYmlkZW500aWZpZXIgTlhzVVhWYlhZRnR4VlNka1hQZEpDY1pybW54Y3hzM2tJMlFlUkFYOVplVQowMDFhY2lkIHRpbWUgPCAxNTI3MzIxMjQzCjAwMmZzaWduYXR1cmUgVHxTRWWdSIFfy302VKEGSFljq1mfJ3KKLJFv2JGg01HMIK
```

### Hotswapping beams

Modules will be hotswapped on a-demo-onedata-lab-provider, a-demo-onedata-cyfronet-provider, a-demo-onedata-infn-provider

```bash
./compile_and_deploy_beam_to_demo.sh ~/one_projects/op-worker-rc14 fslogic_worker index_encoder
```
