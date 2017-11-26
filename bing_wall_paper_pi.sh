#!/bin/bash
#DEBUG
jsonURL="http://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=10"
DATE="$(date +'%F')"
SMTP_SERVER={Your Email Server}
SMTP_PASSWORD={Your Email Password}
export GPGHOME=$GPGHOME

SENDER="{The email used to send }"
RECIPIENT="{The RECIPIENT of this email}"
TMPFILE="$(mktemp -t --tmpdir=$PWD wallpaperJson.XXXXXX)"
FILENAME="$(date +'%Y%m%d%H%M').jpg"

wget -q -O $TMPFILE $jsonURL

imageURL="$(cat $TMPFILE|python3 -c "import sys,json; print(json.load(sys.stdin)['images'][0]['url']);")"
imageName="$(cat $TMPFILE|python3 -c "import sys,json; print(json.load(sys.stdin)['images'][0]['copyright']);")"
imageBaseURL="http://www.bing.com"

MESSAGE="Hello!\n\nAttached is the your Bing image of today: $DATE.\n\n This photo is $imageName\n\nThis is downloaded on $(date +"%c")"


wget -q -O $FILENAME $imageBaseURL$imageURL

if [ -s $FILENAME ]
then 
    echo 'download success'
    printf "$MESSAGE" |s-nail -vr $SENDER -a $FILENAME -s "[Daily Wallpaper] Wallpaper for $DATE is ready" -S smtp=$SMTP_SERVER -S smtp-use-starttls -S smtp-auth=login -S smtp-auth-user=$SENDER -S smtp-auth-password=$SMTP_PASSWORD -S ssl-verify=ignore $RECIPIENT
    rm -f $TMPFILE
fi 

