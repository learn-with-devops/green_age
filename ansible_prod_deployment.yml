---
 - name: Deployment on Production Severs
   hosts: prod-servers
   become: True

   tasks:
   - name: Remove the previous Docker Container
     shell: docker rm -f green_age

   - name: Remove Docker Image
     shell: docker rmi -f $(docker images |grep 'mywebsiteanand/green_age'|awk '{print $3}')

   - name: Create a Docker Container from Image
     shell: docker run -t -d -p 80:80 --name=website mywebsiteanand/green_age
