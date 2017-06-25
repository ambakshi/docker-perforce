Create Service Role for SSM

```sh
aws iam create-role --role-name PTS-SSM-ServiceRole --assume-role-policy-document file://PTS-SSM-ServiceRole.json

aws iam attach-role-policy --role-name PTS-SSM-ServiceRole --policy-arn arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM

aws ssm create-activation --default-instance-name HelixTesting --iam-role PTS-SSM-ServiceRole --registration-limit 10 --region us-east-2
```

SSM Activation Code

```json
{
    "ActivationCode": "vZYFwBe8S+NwUEi8WaBI",
    "ActivationId": "3cda22e2-2c40-4222-818c-e95907f05a67"
}
```

Within the Helix-Server Docker container

```sh
amazon-ssm-agent -register -code "vZYFwBe8S+NwUEi8WaBI" -id "3cda22e2-2c40-4222-818c-e95907f05a67" -region "us-east-2" 

2017/06/22 17:10:14 Failed to load instance info from vault. RegistrationKey does not exist.
Error occurred fetching the seelog config file path:  open /etc/amazon/ssm/seelog.xml: no such file or directory
2017-06-22 17:10:19 INFO Successfully registered the instance with AWS SSM using Managed instance-id: mi-02db0cd24cdee2057
```
