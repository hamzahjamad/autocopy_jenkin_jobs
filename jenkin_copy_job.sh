#!/bin/bash

runcurl(){
	jkusername=$1 
	jkapi=$2 
	newjobname=$3
	jobtocopy=$4
	jkurl=$5 

	#this will copy config of existing job
	curl --user $jkusername:$jkapi "http://$jkurl/job/$jobtocopy/config.xml" > config.xml


	#write a script to edit the config git - TODO

	#this will create a job and use the copied config
	curl --user $jkusername:$jkapi -X POST -H "Content-Type:application/xml" -d @config.xml "http://$jkurl/createItem?name=$newjobname"
}

#
# Check input params
#
if [ -n "${1}" -a -n "${2}" -a -n "${3}" -a -n "$4" -a -n "$5" ]; then 
    runcurl $1 $2 $3 $4 $5
else
    echo "Usage:"
    echo "  Please follow this convention: ${0} 'jenkin_username' 'jenkin_api_token' 'new_job_name' 'job_name_to_copy' 'jenkin_url' "
    exit 1
fi






