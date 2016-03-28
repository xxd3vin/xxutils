#!/bin/bash

script_name=$0

ticket_list=(
17730
17732
17733
17734
17736
17737
17739
17740
17742
17764
17726
17725
17724
17723
17722
17721
17720
17719
17718
17717
17716
17715
17703
17682
17681
17680
17679
17678
17677
17676
17675
17673
17672
17671
17669
17668
17664
17662
17661
17659
17658
17656
17655
17654
17652
17651
17649
17648
17647
17646
17645
17644
17643
17642
17640
17639
17637
17636
17634
17632
17631
17630
17629
17628
17627
17626
17623
17622
17621
17619
17618
17617
17615
17614
17613
17612
17610
17609
17608
17607
17605
17604
17603
17602
17601
17600
17599
17598
17597
17596
17595
17594
17593
17592
17591
17590
17589
17588
17587
17586
17585
17573
17572
17571
17575
17574
17584
17583
17576
17577
17578
17579
17580
17581
17582
17727
17728
17765
)

# debug ticket
ticket_list=(
18654
)

author="ci"
#component="wware后端"
#milestone="[wware] videoplayer.com 视频播放器"
owner="wangyansheng"
#_type="动态化"
#_status="assigned"

for ticket_id in ${ticket_list[@]}
do
  echo $ticket_id
  #cmd="python updateticket.py"
  #cmd="$cmd -i $ticket_id"
  #cmd="$cmd -c \"updateticket.py\""
  #cmd="$cmd -a \"$author\""
  #cmd="$cmd -C \"$component\""
  #cmd="$cmd -m \"$milestone\""
  #cmd="$cmd -o \"$owner\""
  #cmd="$cmd -t \"$_type\""
  #cmd="$cmd -s \"assigned\""
  #echo $cmd
  sudo python updateticket.py -i $ticket_id -c "$script_name" -a "$author" -o "$owner"
done
