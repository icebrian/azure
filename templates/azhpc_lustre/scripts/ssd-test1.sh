# Change this variable to the path of the device you want to test
cd /mnt/sasdata1/

##The following command performs 16 KB random write operations.
fio --name=fio_test_file --direct=1 --rw=randwrite --bs=4k --size=256M --numjobs=8 --time_based --runtime=60 --group_reporting

##The following command performs 16 KB random read operations.
fio --name=fio_test_file --direct=1 --rw=randread --bs=4k --size=256M --numjobs=8 --time_based --runtime=60 --group_reporting