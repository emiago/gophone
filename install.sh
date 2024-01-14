#!/bin/bash

install_dependencies() {
    # Function to install dependencies based on the Linux distribution
    if [ -x "$(command -v apt)" ]; then
        echo "Installing dependencies using apt"
        apt update
        apt install -y curl libportaudio2  # Add your actual dependencies for Debian-based systems
    elif [ -x "$(command -v dnf)" ]; then
        echo "Installing dependencies using dnf"
        dnf install -y curl portaudio  # Add your actual dependencies for Red Hat-based systems
    elif [ -x "$(command -v yum)" ]; then
        echo "Installing dependencies using yum"
        yum install -y curl portaudio  # Add your actual dependencies for Red Hat-based systems
    elif [ -x "$(command -v apk)" ]; then
        echo "Installing dependencies using apk"
        apk update
        apk add curl libportaudio2  # Add your actual dependencies for Alpine
    else
        echo "Unsupported package manager. Please install dependencies manually."
        exit 1
    fi
}

# Detect the Linux distribution
# if [ -e "/etc/os-release" ] && [ -x "$(command -v source)" ]; then
#     source /etc/os-release
#     case "$ID" in
#         debian|ubuntu)
#             echo "Detected Debian-based system."
#             install_dependencies
#             ;;
#         fedora|centos)
#             echo "Detected Red Hat-based system."
#             install_dependencies
#             ;;
#         alpine)
#             echo "Detected Alpine Linux."
#             install_dependencies
#             ;;
#         *)
#             echo "Unsupported Linux distribution. Please install dependencies manually."
#             exit 1
#             ;;
#     esac
# else
#     echo "Unable to detect Linux distribution. Detecting package manager available"
#     install_dependencies
#     # exit 1
# fi

install_dependencies

rm -f gophone
curl -L https://github.com/emiago/gophone/releases/latest/download/gophone -o gophone
chmod +x gophone && mv gophone /usr/bin

rm -f libwhisper.so 
curl -L https://github.com/emiago/gophone/releases/latest/download/libwhisper.so -o libwhisper.so
mv libwhisper.so /usr/lib/

# Ensure any remaining dependencies are resolved
# if [ -x "$(command -v apt)" ]; then
#     sudo apt-get -f install
# elif [ -x "$(command -v dnf)" ]; then
#     sudo dnf install -y
# elif [ -x "$(command -v yum)" ]; then
#     sudo yum install -y
# elif [ -x "$(command -v apk)" ]; then
#     sudo apk add --no-cache
# fi
