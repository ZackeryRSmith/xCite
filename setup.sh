#!/bin/bash

echo "Checking for a python3 installation"
if ! command -v python3 &> /dev/null; then
    printf '\033[1;31mpython3 is not found in path! As setup.sh requires python this script will now abort.\033[0m\n';exit
fi

echo "Checking for a sourceable VENV"
INVENV=$(python3 -c 'import sys ; print(0 if sys.prefix == sys.base_prefix else 1)')
if [ $INVENV -eq 0 ]; then
    if [ -f "bin/activate" ]; then
        echo "Dynamically activating VENV for the remainder of setup.sh's run time"
        source bin/activate
    fi
else echo "VENV already active!"
fi

echo "Checking for requirements.txt"
if [ -f "requirements.txt" ]; then
    echo "Installing requirements"
    python3 -m pip install -r requirements.txt
fi