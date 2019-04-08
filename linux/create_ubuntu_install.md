# 1 Download image

# 2 insert drive, check it name 
`fdisk -l`

# 3 copy disk. thats all (not sdb, but sdb1)
`dd if=~/Downloads/<ubuntu.iso> of=/dev/sdb1`

