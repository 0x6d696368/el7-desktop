#!/bin/bash
echo "Please give me sudo"
sudo echo "Thx"

sudo yum -y update
sudo yum -y install zlib.i686 ncurses-libs.i686 bzip2-libs.i686 java-11-openjdk java-11-openjdk-devel unzip wget 

mkdir ~/apps
cd ~/apps
wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/3.6.3.0/android-studio-ide-192.6392135-linux.tar.gz
tar -xf android-studio-ide-192.6392135-linux.tar.gz
cat > ~/apps/android_studio.sh << EOF
#!/bin/bash
~/apps/android-studio/bin/studio.sh
EOF

