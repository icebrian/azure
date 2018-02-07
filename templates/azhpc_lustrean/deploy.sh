#!/bin/bash
#set -x
#set -xeuo pipefail

#BELOW LINE IS FOR TESTING
cp ../cred_lustre.yaml parameters/cred_lustre.yaml
rm id_rsa* 2> /dev/null
uuid=`cat /dev/urandom | tr -dc 'a-z' | fold -w 4 | head -n 1`

#EDITABLE VARIABLES, CHECK TEMPLATE FOR ALLOWED VALUES
ADMINUSER=lustreuser
#COMPVMSKU=Standard_H16r
#COMPVMSKU=Standard_DS3_v2
COMPVMSKU=Standard_F4s
COMPIMGSKU=CentOS_7.3-HPC
#OSSVMSKU=Standard_F8s
#OSSVMSKU=Standard_DS3_v2
OSSVMSKU=Standard_F4s
location=westeurope
vnetname=an2lustrevnet$uuid

############## NO EDITS BELOW THIS LINE ##############
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

if [ "$#" -ne 4 ]; then
    echo "Usage: ./deploy.sh [RG Name] [OSS NODES] [DISKS per NODE] [COMP NODES]"
    exit
fi

RG=$1
serverNodes=$2
storageDisks=$3
computeNodes=$4

STARTTIME=`date +%Y%m%d_%H%M%S`
LOGDIR=LOGDIR_"$STARTTIME"_$RG
mkdir -p $LOGDIR/parameters

CID=`grep user_id: parameters/cred_lustre.yaml | awk '{print $2}'`
CSEC=`grep password_id: parameters/cred_lustre.yaml | awk '{print $2}'`
TENID=`grep tenant_id: parameters/cred_lustre.yaml | awk '{print $2}'`

echo
echo -e "${GREEN}**********************************************${NC}"
echo -e "${WHITE}Creating a Lustre file server"
echo -e "Resource group: ${YELLOW}$RG${NC}"
echo -e "Storage nodes: ${YELLOW}$serverNodes${NC}"
echo -e "4TB Disks per node: ${YELLOW}$storageDisks${NC}"
echo -e "Total storage (TB): ${YELLOW}`expr $serverNodes \* $storageDisks \* 4`${NC}"
echo -e "Compute nodes: ${YELLOW}$computeNodes${NC}"
echo -e "${GREEN}**********************************************${NC}"
echo

#CREATE MASTER CLUSTER and JUMPBOX USING THE TEMPLATES
echo -e "${GREEN}################ Creating MGSMDT @ ${YELLOW}$STARTTIME${NC}"
az group create -l $location -n $RG -o table
cp parameters/parameters-master.json parameters/.parameters-master.json.orig
ssh-keygen -t rsa -N "" -f id_rsa_lustre > /dev/null
sshkey=`cat id_rsa_lustre.pub`
sed -i "s%_ADMINUSER%$ADMINUSER%g" parameters/parameters-master.json
sed -i "s%_VNETNAME%$vnetname%g" parameters/parameters-master.json
sed -i "s%_SSHKEY%$sshkey%g" parameters/parameters-master.json
sed -i "s%_CID%$CID%g" parameters/parameters-master.json
sed -i "s%_CSEC%$CSEC%g" parameters/parameters-master.json
sed -i "s%_TENID%$TENID%g" parameters/parameters-master.json

echo -e "${PURPLE}################ Validation${NC}"
az group deployment validate -o table --resource-group $RG --template-file templates/lustre-master.json --parameters @parameters/parameters-master.json
echo -e "${BLUE}################ Deployment${NC}"
az group deployment create --name lustre-master-deployment -o table --resource-group $RG --template-file templates/lustre-master.json --parameters @parameters/parameters-master.json

mv parameters/parameters-master.json $LOGDIR/parameters/parameters-master.json
mv parameters/.parameters-master.json.orig parameters/parameters-master.json

pubip=`az network public-ip list -g $RG --query [0].['ipAddress'][0] -o tsv`
mgsip=`az vmss nic list -g $RG --vmss-name mgsmdt --query [*].[ipConfigurations[0].privateIpAddress] -o tsv`
echo -e "jumpbox public ip: ${YELLOW}$pubip${NC}"
echo -e "mgsmdt private ip: ${YELLOW}$mgsip${NC}"
scp -q -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i id_rsa_lustre id_rsa_lustre lustreuser@$pubip:/home/lustreuser/.ssh/
mv id_rsa_lustre* $LOGDIR/
touch $LOGDIR/$pubip

#CREATE OSS SERVER
echo
echo -e "${GREEN}################ Creating OSS Cluster @ ${YELLOW}`date +%Y%m%d_%H%M%S`${NC}"
cp parameters/parameters-server.json parameters/.parameters-server.json.orig
sed -i "s%_OSSVMSKU%$OSSVMSKU%g" parameters/parameters-server.json
sed -i "s%_VNETNAME%$vnetname%g" parameters/parameters-server.json
sed -i "s%_ADMINUSER%$ADMINUSER%g" parameters/parameters-server.json
sed -i "s%_OSSNODES%$serverNodes%g" parameters/parameters-server.json
sed -i "s%_CID%$CID%g" parameters/parameters-server.json
sed -i "s%_CSEC%$CSEC%g" parameters/parameters-server.json
sed -i "s%_TENID%$TENID%g" parameters/parameters-server.json
sed -i "s%_SDS%$storageDisks%g" parameters/parameters-server.json
sed -i "s%_SSHKEY%$sshkey%g" parameters/parameters-server.json

echo -e "${PURPLE}################ Validation${NC}"
az group deployment validate -o table --resource-group $RG --template-file templates/lustre-server.json --parameters @parameters/parameters-server.json
echo -e "${BLUE}################ Deployment${NC}"
az group deployment create --name lustre-server-deployment -o table --resource-group $RG --template-file templates/lustre-server.json --parameters @parameters/parameters-server.json

ossip=`az vmss nic list -g $RG --vmss-name ossserver --query [*].[ipConfigurations[0].privateIpAddress] -o tsv`
echo "OSS Server private ip(s):"
for ip in $ossip; do echo -e "${YELLOW}$ip${NC}"; done

mv parameters/parameters-server.json $LOGDIR/parameters/parameters-server.json
mv parameters/.parameters-server.json.orig parameters/parameters-server.json

#CREATE CLIENTS
echo
echo -e  "${GREEN}################ Creating Compute Cluster @ ${YELLOW}`date +%Y%m%d_%H%M%S`${NC}" 
cp parameters/parameters-client.json parameters/.parameters-client.json.orig
sed -i "s%_ADMINUSER%$ADMINUSER%g" parameters/parameters-client.json
sed -i "s%_VNETNAME%$vnetname%g" parameters/parameters-client.json
sed -i "s%_COMPVMSKU%$COMPVMSKU%g" parameters/parameters-client.json
sed -i "s%_COMPIMGSKU%$COMPIMGSKU%g" parameters/parameters-client.json
sed -i "s%_COMPNODES%$computeNodes%g" parameters/parameters-client.json
sed -i "s%_RG%$RG%g" parameters/parameters-client.json
sed -i "s%_SSHKEY%$sshkey%g" parameters/parameters-client.json

echo -e "${PURPLE}################ Validation${NC}"
az group deployment validate -o table --resource-group $RG --template-file templates/lustre-client.json --parameters @parameters/parameters-client.json
echo -e "${BLUE}################ Deployment${NC}"
az group deployment create --name lustre-client-deployment -o table --resource-group $RG --template-file templates/lustre-client.json --parameters @parameters/parameters-client.json

compip=`az vmss nic list -g $RG --vmss-name compute --query [*].[ipConfigurations[0].privateIpAddress] -o tsv`
echo "Compute Server private ip(s):"
for ip in $compip; do echo -e "${YELLOW}$ip${NC}"; done


mv parameters/parameters-client.json $LOGDIR/parameters/parameters-client.json
mv parameters/.parameters-client.json.orig parameters/parameters-client.json
ENDTIME=`date +%Y%m%d_%H%M%S`
echo
echo -e  "${GREEN}################ Deployment started @ ${YELLOW}$STARTTIME${NC}"
echo -e  "${GREEN}################ Deployment complete @ ${YELLOW}$ENDTIME${NC}"
echo
echo -e  "${WHITE}################ Connection string: ${YELLOW}ssh -i id_rsa_lustre lustreuser@$pubip${NC}"
