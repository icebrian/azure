#!/bin/bash

set -x

CLIENT_ID=$1
CLIENT_SECRET=$2
TENANT_ID=$3
MYUSER=$4


if [[ $(id -u) -ne 0 ]] ; then
    echo "Must be run as root"
    exit 1
fi

if [ $# < 2 ]; then
    echo "Usage: $0 <ManagementHost>"
    exit 1
fi

# Installs all required packages.
install_pkgs()
{
    yum -y -q install epel-release
    yum -y -q install gcc libffi-devel python-devel openssl-devel
    yum -y install openssl openssl-libs gcc-c++ nfs-utils rpcbind mdadm wget python-pip openmpi openmpi-devel automake autoconf pdsh htop
}

setup_user()
{

    MGMT_HOSTNAME=$1
    TEMPLATELINK=$2

    echo "MGS - $MGMT_HOSTNAME and templatelink - $TEMPLATELINK"

    # Shares
    SHARE_HOME=/share/home
    SHARE_SCRATCH=/share/scratch

    LUSTRE_CLIENT=/mnt/lustre

    # User
    HPC_USER=hpcuser
    HPC_UID=7007
    HPC_GROUP=hpc
    HPC_GID=7007

    mkdir -p $SHARE_HOME
    mkdir -p $SHARE_SCRATCH

	echo "$MGMT_HOSTNAME:$SHARE_HOME $SHARE_HOME    nfs4    rw,auto,_netdev 0 0" >> /etc/fstab
	mount -a
	mount
   
    groupadd -g $HPC_GID $HPC_GROUP

    # Don't require password for HPC user sudo
    echo "$HPC_USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
    
    # Disable tty requirement for sudo
    sed -i 's/^Defaults[ ]*requiretty/# Defaults requiretty/g' /etc/sudoers

	useradd -c "HPC User" -g $HPC_GROUP -d $SHARE_HOME/$HPC_USER -s /bin/bash -u $HPC_UID $HPC_USER

    chown $HPC_USER:$HPC_GROUP $SHARE_SCRATCH

	
}
az_login()
{
    #install az cli
    wget https://azurecliprod.blob.core.windows.net/install.py
    python install.py << ANSWERS
/home/$USER/lib/azure-cli
/home/$USER/bin
Y
/home/$USER/.bashrc
ANSWERS

    az login --service-principal -u $CLIENT_ID -p $CLIENT_SECRET --tenant $TENANT_ID
}

systemctl stop firewalld
systemctl disable firewalld

# Disable SELinux
sed -i 's/SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config
setenforce 0

install_pkgs
#setup_user
az_login

shutdown -r +1 &
exit 0