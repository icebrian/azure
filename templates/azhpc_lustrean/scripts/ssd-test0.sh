cd /mnt/lustre/

# Random WRITE
fio --name=randwrite --ioengine=libaio --iodepth=1 --rw=randwrite --bs=4k --direct=0 --size=256M --numjobs=8 --runtime=60 --group_reporting

# Random READ
fio --name=randread --ioengine=libaio --iodepth=16 --rw=randread --bs=4k --direct=0 --size=256M --numjobs=8 --runtime=60 --group_reporting