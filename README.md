# lenovoEMC-300d
##How to gain access to a PX6-300d stuck with "USB-Network" icon, using Ubuntu Linux

 * first read this to know how to attach an USB-Serial console to the mainboard

 open-desk.org/?p=276
 * Buy this cable

 https://www.adafruit.com/products/954

 * Get a 4GB USB drive, format it FAT
 * Mount USB drive
 * Get the latest recovery image from https://lenovo-eu-en.custhelp.com/app/cust_alp/p/1189,1190
   As to 2016.01.08 the image is called: px4px6-4.1.114.33421.tgz and can be downloaded from: https://lenovo-eu-en.custhelp.com/app/answers/detail/a_id/27366
  * get and edit the **create-fw-usb.sh** script
  
     set the USB path right (mine was /media/B966-AAE2)
     
     usb=/media/B966-AAE2
     
     I you downloaded a newer firmware than *px4px6-4.1.114.33421.tgz* set the **ifw** to the correct filename

* place the firmware TGZ and the script into the same folder
* run **create-fw-usb.sh** to create the Firmware update disk
* run sync then unmount the USB Flash disk
* connect the USB-Serial, (you may need to join dialout group, or add RW to Other for /dev/ttyUSB0)
* start Putty on Ubuntu, connect with 115200 to /dev/ttyUSB0 
* Connect USB Flash disk to front connector on the device
* Start the device, and **prepare to press the rear reset button**
* At "GRUB" heavily press ESC
 * Select **SOHO** if the highlighted item was SOHODeep, then press Enter
 * Follow carefully the onscreen info until you see **"Checking to see the if the reset button is pressed or not"**
 * **Press the rear reset button** as fast as you can, if you fail, it is the best you start over by pulling power...
* The system should start the firmware upgrade, after that you should see a clean shutdown
* Boot the system
* At "GRUB" heavily press ESC
* Make sure **SOHO** was the default selected, and press Enter
* Watch the device boot to Debian Wheezy, and proceed to the Web-Admin to set-up your device
