#!/bin/bash

# RUN THIS ONLY WHEN YOU'RE STARTING A NEW PROJECT!
# Usage:
# ./setup.sh

read -p "What is your project name? -> " PROJECT_NAME

APP_NAME=$PROJECT_NAME\_app

echo "Creating project $PROJECT_NAME"
cd ..
cp -r ren_project $PROJECT_NAME
cd $PROJECT_NAME 

echo "Cleaning old shit"
rm -rf ren_project_venv
rm -rf $PROJECT_NAME\_venv
rm -f db.sqlite3

echo "Replacing files with new project name"
find . -type f -exec sed -i 's/ren_project/'$PROJECT_NAME'/g' "{}" +;
find . -type f -exec sed -i 's/ren_app/'$APP_NAME'/g' "{}" +;

echo "Renaming files and directories"
mv ren_project $PROJECT_NAME
mv ren_app $PROJECT_NAME\_app

echo "Creating virtual environment"
virtualenv $PROJECT_NAME\_venv
source $PROJECT_NAME\_venv/bin/activate

echo "Installing requirements"
pip install -r requirements.txt
./manage.py collectstatic --noinput
./manage.py syncdb --noinput

echo "Removing setup file"
rm -f ./setup.sh

echo
echo "All done! Now -> ./run.sh [port_number]"
