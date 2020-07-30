# New MT files

This folder contains time-stamped subdirectories which each subdirectory shows received data from each user.

For just 3 languages (de, cs, and en) files in these subdirectories, there is exist a directory by name "file_name"-broken_files.
e.g. for the file outputs/20200513-uedin-phil/cs2en.txt, we have a folder by name outputs/20200513-uedin-phil/cs2en-broken_files/ 

Each one of *-broken_files directory contains 4 subdirectory (antrocrop, khan-academy, sao-wget, and sao-consecutive) because we used test set data, and finally, each one of them contains new files with individual files name before concatenation. 

e.g. for outputs/20200513-uedin-phil/en2de.txt file  there is:

outputs/20200513-uedin-phil/en2de-broken_files/sao-wgvat/belgian.TTde
outputs/20200513-uedin-phil/en2de-broken_files/sao-wgvat/romanian.TTde
outputs/20200513-uedin-phil/en2de-broken_files/sao-wgvat/polish.TTde 
outputs/20200513-uedin-phil/en2de-broken_files/sao-wgvat/spanish.TTde 

outputs/20200513-uedin-phil/en2de-broken_files/sao-consecutive/austrian.TTde 
outputs/20200513-uedin-phil/en2de-broken_files/sao-consecutive/austrian.TTde 

outputs/20200513-uedin-phil/en2de-broken_files/khan-academy/kaccNlwi6lUCEM.TTde 
outputs/20200513-uedin-phil/en2de-broken_files/khan-academy/kach_fBMnB1i-0.TTde 
...

outputs/20200513-uedin-phil/en2de-broken_files/antrecorp/03_botel-proti-proudu.TTde 
outputs/20200513-uedin-phil/en2de-broken_files/antrecorp/04_g-t.TTde 
...








