#!/bin/bash

code_clone(){
  echo "Cloning the code"
  git clone https://github.com/LondheShubham153/django-notes-app.git 
}

install_dependency(){
 echo "Installing dependencies.."
 sudo apt-get update && sudo apt-get install docker.io  docker-compose -y
}

enable_package(){
 echo "Enabling the packages"
 sudo systemctl enable docker
 sudo systemctl enable nginx

 #Allow current user ownership of docker socket so no need to use sudo every time to run docker cmd.
 sudo chown $USER /var/run/docker.sock
}

deploy(){
 echo "Deploying the project django-notes-app"
 docker compose up -d
}


echo"******************** Deployment started  ************************"

if ! code_clone; then
	echo "Code already cloned.."
	cd django-notes-app
fi

if ! install_dependency; then
	echo "Dependency installation failed..."
	exit 1
fi

if ! enable_package; then
	echo "Package enabling failed"
        exit 1
fi

if ! deploy; then
	echo "Deployment failed error..."
	exit 1
fi

echo "****************Deployment Done ******************************"

