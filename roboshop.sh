#!/bin/bash

AMI=ami-0b4f379183e5706b9 #this keeps on changing
<<<<<<< HEAD
SG_ID=subnet-04059f911756051a5 #replace with your SG ID
=======
SG_ID=sg-0974791d5a9360e0f #replace with your SG ID
>>>>>>> 9bcdf0231791404c131f93795d29ef41fe10bf31
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "web")
ZONE_ID=Z06421211ES3IRIHBMUE0 # replace your zone ID
DOMAIN_NAME="gdharma.xyz"

for i in "${INSTANCES[@]}"
do
    if [ $i == "mongodb" ] || [ $i == "mysql" ] || [ $i == "shipping" ]
    then
        INSTANCE_TYPE="t3.small"
    else
        INSTANCE_TYPE="t2.micro"
    fi

<<<<<<< HEAD
    IP_ADDRESS=$(aws ec2 run-instances --image-id $AMI --instance-type $INSTANCE_TYPE --security-group-ids sg-087e7afb3a936fce7 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" --query 'Instances[0].PrivateIpAddress' --output text)
=======
    IP_ADDRESS=$(aws ec2 run-instances --image-id $AMI --instance-type $INSTANCE_TYPE --security-group-ids sg-008ec3ba4d4402c28 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" --query 'Instances[0].PrivateIpAddress' --output text)
>>>>>>> 9bcdf0231791404c131f93795d29ef41fe10bf31
    echo "$i: $IP_ADDRESS"

    #create R53 record, make sure you delete existing record
    aws route53 change-resource-record-sets \
    --hosted-zone-id $ZONE_ID \
    --change-batch '
    {
        "Comment": "Creating a record set for cognito endpoint"
        ,"Changes": [{
        "Action"              : "UPSERT"
        ,"ResourceRecordSet"  : {
            "Name"              : "'$i'.'$DOMAIN_NAME'"
            ,"Type"             : "A"
            ,"TTL"              : 1
            ,"ResourceRecords"  : [{
                "Value"         : "'$IP_ADDRESS'"
            }]
        }
        }]
    }
        '
<<<<<<< HEAD
done
=======
done
>>>>>>> 9bcdf0231791404c131f93795d29ef41fe10bf31
