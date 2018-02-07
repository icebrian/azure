# Change this variable to the path of the device you want to test
block_dev=/mnt/lustre/fiotest1

##The following command performs 16 KB random write operations.

fio --filename=$block_dev --name=fio_test_file --direct=1 --rw=randwrite --bs=4k --size=1G --numjobs=16 --time_based --runtime=180 --group_reporting

##The following command performs 16 KB random read operations.

fio --filename=$block_dev --name=fio_test_file --direct=1 --rw=randread --bs=4k --size=1G --numjobs=16 --time_based --runtime=180 --group_reporting