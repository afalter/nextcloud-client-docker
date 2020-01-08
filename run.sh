#!/bin/ash

# ensure, that the sync dir exists and is owned by the user
[ -d /media/nextcloud ] || mkdir -p /media/nextcloud
echo "chown -R $USER:$GROUP /media/nextcloud"
chown -R $USER:$GROUP /media/nextcloud

while true
do
	/bin/su -s /bin/ash $USER -c 'umask 0000 && nextcloudcmd $( [ "$NC_HIDDEN" == true ] && echo "-h" ) $( [ "$NC_SILENT" == true ] && echo "--silent" ) $( [ "$NC_TRUST_CERT" == true ] && echo "--trust" ) --non-interactive -u $NC_USER -p $NC_PASS /media/nextcloud $NC_URL'
	
	#check if exit!
	if [ "$NC_EXIT" = true ] ; then
		if [  ! "$NC_SILENT" == true ] ; then 
			echo "NC_EXIT is true so exiting... bye!"
		fi			
		exit;
	fi
	sleep $NC_INTERVAL
done
