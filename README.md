# sparsh-project

Automated deployment

1- created a file named " generate_numbers.sh " which generates a file test.txt ..... generates random variable from 0-9.
2- Created a apihit.py file which has a rest API Strucure calling the end points ..
3- after checking the END points are available through post-man , we are putting it into the container
4- installed docker and build an image consisting of the rest-api "apihit.py" & the docker image is at docker hub , apihit.py and generate_number.sh both are cooked up in docker image and exposing port 5000.
5- There is a file known as "main.tf" which will apply all those changes in the form of AWS EC2 Instance (IAAS) through Terraform
6- " generate_numbers.sh ", "apihit.py" , " docker file " , "main.tf" all files are  present in the github repo
