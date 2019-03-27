#
# This script is used to Sideload the Application to a Roku device.
#
# If will copy the relevant files to the directories so that they
# are included in the build.
#
# Parameters: <IpAddress> <Roku Password>
#

TESTS=no
PASSWORD=1111

if [ "$1" ]; then
	ROKU_IP=$1
else
	ROKU_IP=192.168.43.3
fi

if [ "$2" ]; then
    if [ "$2" == "-test" ]; then
        TESTS=yes
    else
    	PASSWORD=$2
    fi
fi

USERNAME=rokudev

ROKU_LIB_PATH=../Roku-Lib

ROKU_TMP_FOLDER=/tmp/rokuTmp/build
PROJECT_PATH=$(pwd)
ROKU_ZIP=$PROJECT_PATH/out/hello_sideload.zip
ROKU_OUT_FOLDER=$PROJECT_PATH/out

uproku ()
{
    if [ "$1" ] && [ "$2" ]; then 
        uagent='Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)';
    
        curl -v --user $USERNAME:$PASSWORD  --anyauth -S -F "mysubmit=Install" -F "archive=@$ROKU_ZIP" -F "passwd=" http://$ROKU_IP/plugin_install 2> /dev/null | grep "<font color" | sed "s/<font color=\"red\">//"

        echo "size on disk is $(ls -alb $1 |awk '{ print $5 }') bytes ";
    else
        echo -e "this will upload a zip to a roku, you input too few arguments format is\nuproku zipname IPaddress_of_ROKU ";  
    fi
}

copyProjectFolders()
{
    folder=$1
    cp -r $folder $ROKU_TMP_FOLDER
}

ziproku() 
{

    if [ -d $ROKU_TMP_FOLDER ]
    then
        rm -r $ROKU_TMP_FOLDER
    fi
    
    if [ -d $ROKU_OUT_FOLDER ]
    then
		rm $ROKU_ZIP
    	
	else
  		mkdir $ROKU_OUT_FOLDER	
	fi 

    mkdir -p $ROKU_TMP_FOLDER
 
    if [ $TESTS = "yes" ]; then
        # make the tests and copy across
        rooibosC p source/tests .
        copyProjectFolders data
    fi
   
    # copy main files
    copyProjectFolders source
    copyProjectFolders components
    copyProjectFolders images
    copyProjectFolders manifest

    # Finally make the build and deploy it
    (cd $ROKU_TMP_FOLDER &&  zip -9 -r $ROKU_ZIP . > /dev/null )
}

ziproku
uproku $ROKU_ZIP $ROKU_IP
