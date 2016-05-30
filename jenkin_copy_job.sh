#!/bin/bash

xmlModifier(){

	XML_FILE_TO_MODIFY=$1
	element_selector=$2

	if [ -z "$4" ]; then 
	    new_value=$3
	else
	 	new_value="https:\/\/$3@bitbucket.org\/$3\/$4.git"
	fi

	sed -i "s/\(<$element_selector.*>\).*\(<\/$element_selector.*\)/\1$new_value\2/" $XML_FILE_TO_MODIFY
}


runcurl(){
	jkusername=$1 
	jkapi=$2 
	newjobname=$3
	jobtocopy=$4
	jkurl=$5 

	#this will copy config of existing job
	curl --user $jkusername:$jkapi "http://$jkurl/job/$jobtocopy/config.xml" > config.xml

	#rewrite the config, change its repository url and jenkins_project_token
	xmlModifier config.xml authToken $6 #jenkin_project_token
	xmlModifier config.xml url $7 $8 #bitbucket_username & bitbucket_repository_name

	#this will create a job and use the copied config
	curl --user $jkusername:$jkapi -X POST -H "Content-Type:application/xml" -d @config.xml "http://$jkurl/createItem?name=$newjobname"

	#remove the cofig file
	rm config.xml
}

#
# Check input params
#
if [ -n "${1}" -a -n "${2}" -a -n "${3}" -a -n "$4" -a -n "$5" -a -n "$6" -a -n "$7" -a -n "$8" ]; then 
    runcurl $1 $2 $3 $4 $5 $6 $7 $8
else
    echo "Usage:"
    echo "  Please follow this convention: ${0} 'jenkin_username' 'jenkin_user_api_token' 'new_job_name' 'job_name_to_copy' 'jenkin_url' 'jenkin_project_token' 'bitbucket_username' 'bitbucket_repository_name'"
    exit 1
fi






