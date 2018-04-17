```
Steps : 
      1. Get the code from following repository: 
	https://github.com/saqib23/devops-project.git
      2.  Install Ansible, awscli, python, and boto (pip install boto3)
      3. Configure key’s in anisble config file as follows : 
          private_key_file = /home/ubuntu/<your_private_key.pem>
      4. Now move to folder devops-project and execute command 
ansible-playbook -i hosts ec2-nginx.yml

```
