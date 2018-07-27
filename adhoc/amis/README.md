# AMI Base Images

## Setup

Install the [packer](https://www.packer.io) v1.2.3 release.

## Usage


First build core,

```sh
cd core
packer build -var-file=vars.json -color=false packer.json | tee build.log
```

then build base using `AMI ID` of core.

```sh
cd base
packer build -var-file=vars.json -color=false packer.json | tee build.log
```

Forgot the ID? Try this:

```sh
cd core
egrep "${AWS_REGION}\:\sami\-" build.log | cut -d' ' -f2 > ami_id.txt
```

### Example `vars.json` files

```json
{
 "aws_access_key": "myaccesskey",
 "aws_secret_key": "mysecretkey",
 "aws_region": "us-east-1",
 "rhsm_username": "",
 "rhsm_password": "",
 "rhsm_org_id": "myrhsmorgid",
 "rhsm_key_id": "myrhsmkeyid",
 "rhsm_pool_id": "",
 "ami_id": "ami-c998b6b2"
}
```

```json
{
 "aws_access_key": "myaccesskey",
 "aws_secret_key": "mysecretkey",
 "aws_region": "us-east-1",
 "rhsm_username": "myrhsmaccount",
 "rhsm_password": "myrhsmpassword",
 "rhsm_org_id": "",
 "rhsm_key_id": "",
 "rhsm_pool_id": "",
 "ami_id": "ami-c998b6b2"
}
```

```json
{
 "aws_access_key": "myaccesskey",
 "aws_secret_key": "mysecretkey",
 "aws_region": "us-east-1",
 "rhsm_username": "myrhsmaccount",
 "rhsm_password": "myrhsmpassword",
 "rhsm_org_id": "",
 "rhsm_key_id": "",
 "rhsm_pool_id": "myrhsmpoolid",
 "ami_id": "ami-c998b6b2"
}
```
