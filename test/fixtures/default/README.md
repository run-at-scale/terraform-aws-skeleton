# test_fixtures example
This set of templates serves two purposes:
0. shows developers how to use the module as integrated with other Terraform community supported and registry modules.
1. serves as the test infrastructure for CI on the project.

## IAM policy
The following IAM policy should be applied to the user running these tests:
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1506647820867",
            "Action": [
                "ec2:DescribeAccountAttributes"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1506648322533",
            "Action": [
                "lambda:GetAccountSettings"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1506648337686",
            "Action": [
                "rds:DescribeAccountAttributes"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
```
