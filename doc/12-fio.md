## Виртуалка с matchbox

```
fio --name=benchtest \
    --size=800m \
    --filename=/home/user/test.fio \
    --direct=1 \
    --rw=randrw \
    --ioengine=libaio \
    --bs=4k \
    --iodepth=16 \
    --numjobs=8 \
    --time_based \
    --runtime=60
```

### NVME
```
--------------------
2 cpu 2 ram 
--------------------

Run status group 0 (all jobs):
   READ: bw=131MiB/s (137MB/s), 16.0MiB/s-16.5MiB/s (16.8MB/s-17.3MB/s), io=7840MiB (8221MB), run=60001-60001msec
  WRITE: bw=131MiB/s (137MB/s), 16.0MiB/s-16.6MiB/s (16.8MB/s-17.4MB/s), io=7848MiB (8229MB), run=60001-60001msec

Disk stats (read/write):
  sda: ios=2002743/2004728, merge=0/18, ticks=466650/91455, in_queue=558146, util=99.88%

--------------------
4 cpu 4 ram 
--------------------

Run status group 0 (all jobs):
   READ: bw=273MiB/s (287MB/s), 34.1MiB/s-34.2MiB/s (35.8MB/s-35.9MB/s), io=16.0GiB (17.2GB), run=60002-60002msec
  WRITE: bw=274MiB/s (287MB/s), 34.1MiB/s-34.3MiB/s (35.8MB/s-35.9MB/s), io=16.0GiB (17.2GB), run=60002-60002msec

Disk stats (read/write):
  sda: ios=4192591/4195041, merge=0/12, ticks=4486287/2556398, in_queue=7042733, util=99.89%
```

### SATA
```
--------------------
2 cpu 2 ram 
--------------------

Run status group 0 (all jobs):
   READ: bw=47.4MiB/s (49.7MB/s), 6037KiB/s-6096KiB/s (6182kB/s-6242kB/s), io=2843MiB (2982MB), run=60004-60006msec
  WRITE: bw=47.4MiB/s (49.7MB/s), 6047KiB/s-6087KiB/s (6192kB/s-6233kB/s), io=2843MiB (2981MB), run=60004-60006msec

Disk stats (read/write):
  sdb: ios=727389/727245, merge=0/18, ticks=3311803/4113322, in_queue=7425187, util=99.90%
  
--------------------
4 cpu 4 ram 
--------------------

Run status group 0 (all jobs):
   READ: bw=47.2MiB/s (49.5MB/s), 6024KiB/s-6076KiB/s (6169kB/s-6222kB/s), io=2834MiB (2971MB), run=60005-60007msec
  WRITE: bw=47.2MiB/s (49.5MB/s), 6026KiB/s-6059KiB/s (6170kB/s-6205kB/s), io=2833MiB (2970MB), run=60005-60007msec

Disk stats (read/write):
  sdb: ios=724056/723798, merge=0/12, ticks=3397437/4206001, in_queue=7603511, util=99.89%
```

## Mayastor

```
--------------------
1 replic
--------------------

Run status group 0 (all jobs):
   READ: bw=121MiB/s (126MB/s), 13.4MiB/s-17.3MiB/s (14.0MB/s-18.2MB/s), io=7235MiB (7586MB), run=60001-60003msec
  WRITE: bw=121MiB/s (127MB/s), 13.4MiB/s-17.4MiB/s (14.1MB/s-18.2MB/s), io=7243MiB (7595MB), run=60001-60003msec

Disk stats (read/write):
  nvme0n1: ios=1849976/1852100, merge=0/18, ticks=1443974/1150760, in_queue=2594736, util=99.94%
  
--------------------
3 replic
--------------------

Run status group 0 (all jobs):
   READ: bw=62.5MiB/s (65.6MB/s), 7775KiB/s-8374KiB/s (7961kB/s-8575kB/s), io=3751MiB (3933MB), run=60001-60002msec
  WRITE: bw=62.5MiB/s (65.6MB/s), 7757KiB/s-8355KiB/s (7943kB/s-8556kB/s), io=3753MiB (3935MB), run=60001-60002msec

Disk stats (read/write):
  nvme0n1: ios=956930/957348, merge=0/18, ticks=1186316/1063994, in_queue=2250318, util=99.95%
```

## Linstor

```
--------------------
1 replic
--------------------

   READ: bw=128MiB/s (134MB/s), 14.6MiB/s-17.5MiB/s (15.3MB/s-18.3MB/s), io=7683MiB (8056MB), run=60001-60002msec
  WRITE: bw=128MiB/s (134MB/s), 14.6MiB/s-17.5MiB/s (15.3MB/s-18.3MB/s), io=7693MiB (8067MB), run=60001-60002msec

Disk stats (read/write):
    drbd1000: ios=1963650/1966140, merge=0/0, ticks=650960/250796, in_queue=901756, util=99.89%, aggrios=1966887/1969429, aggrmerge=0/0, aggrticks=626436/214284, aggrin_queue=840720, aggrutil=99.78%
    dm-0: ios=1966887/1969429, merge=0/0, ticks=626436/214284, in_queue=840720, util=99.78%, aggrios=1966887/1969410, aggrmerge=0/19, aggrticks=612590/215435, aggrin_queue=828068, aggrutil=99.79%
  vdc: ios=1966887/1969410, merge=0/19, ticks=612590/215435, in_queue=828068, util=99.79%

--------------------
3 replic
--------------------

   READ: bw=63.2MiB/s (66.3MB/s), 8066KiB/s-8142KiB/s (8260kB/s-8338kB/s), io=3792MiB (3977MB), run=60001-60005msec
  WRITE: bw=63.2MiB/s (66.3MB/s), 8062KiB/s-8132KiB/s (8256kB/s-8327kB/s), io=3795MiB (3979MB), run=60001-60005msec

Disk stats (read/write):
    drbd1000: ios=970241/971004, merge=0/0, ticks=666300/5294412, in_queue=5960712, util=99.54%, aggrios=970829/971570, aggrmerge=0/0, aggrticks=662432/112636, aggrin_queue=775068, aggrutil=98.41%
    dm-0: ios=970829/971570, merge=0/0, ticks=662432/112636, in_queue=775068, util=98.41%, aggrios=970829/971551, aggrmerge=0/19, aggrticks=660074/114273, aggrin_queue=774446, aggrutil=98.41%
  vdc: ios=970829/971551, merge=0/19, ticks=660074/114273, in_queue=774446, util=98.41%
```