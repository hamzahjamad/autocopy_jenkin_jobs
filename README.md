## SYNOPSIS
This is a script to create a new job on jenkins by copying existed job. It just download the config of another job and 
rewrite its Repository Url and the project token  

## USAGE
For this time the script must be running the variable sequence correctly, or else it will break  
{script name} 'jenkin_username' 'jenkin_user_api_token' 'new_job_name' 'job_name_to_copy' 'jenkin_url' 'jenkin_project_token' 'repository'  

for example (in windows)    
sh jenkin_copy_job.sh username user_api_token new_job_name job_name_to_copy jenkin.test:8080 'jenkin_project_token' https://user@bitbucket.org/user/repo.git  

## PLEASE NOTE
'new_job_name' and 'job_name_to_copy' need to be url encoded first  
'jenkin_url' , dont include http:// infront of it