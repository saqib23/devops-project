```
Steps : 
      1. Get the code from following repository: 
	https://github.com/saqib23/devops-project.git
      2.  Install Ansible, awscli, python, and boto (pip install boto3)
      3. Configure key’s in anisble config file as follows : 
          private_key_file = /home/ubuntu/<your_private_key.pem>
      4. Now move to folder devops-project and execute command 
ansible-playbook -i hosts ec2-nginx.yml -vvv

Ansible : It would create the instance and install NGINX while a bash script is called within ansible over that created instance which would trigger and generate self-signed SSL certificate. bash script is named as `cert_creation.sh` which accepts arguments as --self for execution with domain name and location which is passed in ansible.

```
```
Bash Script

For creating EC2 instance using bash script using bash_script/ec2_installation.sh. 
	 usage: ./ec2_installation.sh start (spin up EC2 )
            ./ec2_installation.sh stop (terminate the EC2 instance to save money)

For Installing Nginx copy Nginx folder to created server and execute `Nginx_config_ssl.sh`. To change any configuration change `configuration.cfg`. 

```