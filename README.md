# CentOS 7 desktop install

## BASE INSTALL

### NETWORK & HOSTNAME

Connect (for install).

### DATE & TIME

Set time zone and enable optionally enable NTP.

### INSTALLATION SOURCE

`On the network: http://mirror.centos.org/centos/7/os/x86_64/`

### SOFTWARE SELECTION

`Minimal Install`

### INSTALLATION DESTINATION

Automatic works ... even for only 2 GiB HDD.

May want to do separate `/home` and  `/tmp` to mount them `noexec`.

Recommended to setup encryption.

## CONFIGURATION

After hitting INSTALL you can configure user settings.

### USER SETTINGS

Don't set a `ROOT PASSWORD`.

Add a user via `USER CREATION` and make that user administrator (uses `sudo`).

## SETUP

After installation you need to setup the installation by running some of the
`.sh` scripts:

* `01_install_closed_firewall.sh`: for install where you don't want SSH (physical machine)
* `01_install_i3.sh`: my basic i3wm desktop install (has some dependencies)
* `02_install_vboxguest.sh`: for installing the Virtualbox guest additions (virtual installation)
* `03_install_apps.sh`: install main set of applications that I use (only from main CentOS repos)
* `04_install_apps.sh`: install main set of applications that I use (including from EPEL)
* `05_install_apps.sh`: install main set of applications that I use (including from nux-dextop)
* `06_update_openvpn.sh`: set SElinux stuff when you update OpenVPN config
* `07_{install,update}_virtualbox.sh`: install  VirtualBox and update/rebuild DKMS (needed after kernel updates)
* `08_{install,update}_kernel-ml.sh`: install and update mainline kernel from the elrepo.org repository


## Stupid fixes

### Chromium / Chrome

* `chrome://flags/#omnibox-ui-hide-steady-state-url-scheme-and-subdomains`

### Firefox

* `about:config`
	* `keyword.enabled` = `false`
	* `browser.fixup.alternate.enabled` = `false`
	* `browser.search.widget.inNavBar` = `true`
	* `browser.search.suggest.enabled` = `false`
	* `browser.urlbar.autoFill` = `false`
	* `browser.urlbar.autoFill.typed` = `false`
	* `browser.urlbar.suggest.bookmark` = `true`
	* `browser.urlbar.suggest.history` = `false`
	* `browser.urlbar.suggest.openpage` = `false`
	* `browser.urlbar.formatting.enabled` = `false`
	* `browser.safebrowsing.downloads.enabled` = `false`
	* `browser.safebrowsing.malware.enabled` = `false`
	* `browser.safebrowsing.phishing.enabled` = `false`
	* `datareporting.healthreport.uploadEnabled` = `false`
	* `extensions.screenshots.upload-disabled` = `true`
	* `network.IDN_show_punycode` = `true`
	* TODO 
	
* Add-ons:
	* uBlock Origin
	* NoScript
	* HTTPS Everywhere
	* Offline QR Code [optional]

### Thunderbird

* Add-ons:
	* Enigmail
	* DKIMVerify

* POP settings: 
![Thunderbird Settings](thunderbird/01.png)
![Thunderbird Settings](thunderbird/02.png)
![Thunderbird Settings](thunderbird/03.png)
![Thunderbird Settings](thunderbird/04.png)
![Thunderbird Settings](thunderbird/05.png)
![Thunderbird Settings](thunderbird/06.png)
![Thunderbird Settings](thunderbird/07.png)
![Thunderbird Settings](thunderbird/08.png)
![Thunderbird Settings](thunderbird/09.png)
![Thunderbird Settings](thunderbird/10.png)
![Thunderbird Settings](thunderbird/11.png)
![Thunderbird Settings](thunderbird/12.png)
![Thunderbird Settings](thunderbird/13.png)
![Thunderbird Settings](thunderbird/14.png)
![Thunderbird Settings](thunderbird/15.png)
![Thunderbird Settings](thunderbird/16.png)
![Thunderbird Settings](thunderbird/17.png)

## LUKS

### Format

```
sudo cryptsetup luksFormat /dev/sdb1
sudo cryptsetup luksOpen /dev/sdb1 new
sudo mkfs.ext4 /dev/mapper/new [-L <disk label>]
sudo e2label /dev/mapper/new <new disk label>
sudo cryptsetup luksClose new
```

### Add key

```
sudo cryptsetup luksAddKey /dev/sdb1
```

### Mount cloned drive (that has UUID of already mounted drive)

```
sudo cryptsetup luksOpen /dev/sdb1 old
sudo mount -o nouuid /dev/mapper/old ~/mnt
# do stuff
sudo umount ~/mnt
sudo cryptsetup luksClose old
```

## Misc

### Generate QR code

To transfer links and other data to a smartphone use:

```
echo "https://thislinkintoa.qr" | qrencode -t utf8
```

## Key integrity

Make sure to check the integrity of the repository keys!

```
$ for i in $(ls /etc/pki/rpm-gpg/RPM-GPG-KEY-*); do gpg --with-fingerprint "${i}"; done
pub  4096R/0x24C6A8A7F4A80EB5 2014-06-23 CentOS-7 Key (CentOS 7 Official Signing Key) <security@centos.org>
      Key fingerprint = 6341 AB27 53D7 8A78 A7C2  7BB1 24C6 A8A7 F4A8 0EB5
pub  2048R/0xD0F25A3CB6792C39 2014-07-15 CentOS-7 Debug (CentOS-7 Debuginfo RPMS) <security@centos.org>
      Key fingerprint = 759D 690F 6099 2D52 6A35  8CBD D0F2 5A3C B679 2C39
pub  4096R/0xC78893AC8FAE34BD 2014-06-04 CentOS-7 Testing (CentOS 7 Testing content) <security@centos.org>
      Key fingerprint = BA02 A5E6 AFF9 70F7 269D  D972 C788 93AC 8FAE 34BD
pub  1024D/0x309BC305BAADAE52 2009-03-17 elrepo.org (RPM Signing Key for elrepo.org) <secure@elrepo.org>
      Key fingerprint = 96C0 104F 6315 4731 1E0B  B1AE 309B C305 BAAD AE52
sub  2048g/0xF46A3776B8C66E6D 2009-03-17
pub  4096R/0x6A2FAEA2352C64E5 2013-12-16 Fedora EPEL (7) <epel@fedoraproject.org>
      Key fingerprint = 91E9 7D7C 4A5E 96F1 7F3E  888F 6A2F AEA2 352C 64E5
pub  4096R/0xE98BFBE785C6CD8A 2011-06-25 Nux.Ro (rpm builder) <rpm@li.nux.ro>
      Key fingerprint = 561C 96BD 2F7F DC2A DB5A  FD46 E98B FBE7 85C6 CD8A
sub  4096R/0xAB41227CEDD81BD3 2011-06-25
pub  1024D/0x54422A4B98AB5139 2010-05-18 Oracle Corporation (VirtualBox archive signing key) <info@virtualbox.org>
      Key fingerprint = 7B0F AB3A 13B9 0743 5925  D9C9 5442 2A4B 98AB 5139
sub  2048g/0xB6748A65281DDC4B 2010-05-18
```

## TODO

* Integrate PGP key verification/import




