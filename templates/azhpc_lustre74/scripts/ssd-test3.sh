
# Lustre Mount Point
cd /mnt/lustre/

# Random read/write performance
# 
# This will create a 1 GB file, and perform 4KB reads and writes using a 75%/25% 
# (ie 3 reads are performed for every 1 write) split within the file, with 64 operations 
# running at a time. The 3:1 ratio is a rough approximation of your typical database.

fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=test --bs=4k --iodepth=64 --size=1G --readwrite=randrw --rwmixread=75
