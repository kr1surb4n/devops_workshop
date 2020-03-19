#!/usr/bin/env bash
# Display usage instructions
usage() { echo "Usage: $0 [-p <Playbook Path>] [-t <Playbook
Title>]" 1>&2; exit 1; }
# Gather the users options
while getopts ":p:t:" OPTION; do
    case "${OPTION}" in
    p)
PROJECT_PATH=${OPTARG}
;;
    t)
PLAYBOOK_TITLE=${OPTARG}
;;
*)
usage
;;
esac
done
# If the user missed a switch, get them remind them that
# they need to add it.
if [ -z ${PROJECT_PATH} ]; then
echo "You need to supply a Project Path"
exit 1
fi
if [ -z ${PLAYBOOK_TITLE} ]; then
echo "You need to supply a Project Title"
exit 1
fi

# Now we have the path and title, build the layout
mkdir -p "${PROJECT_PATH}/files"
mkdir -p "${PROJECT_PATH}/group_vars"
mkdir -p "${PROJECT_PATH}/host_vars/dev"
mkdir -p "${PROJECT_PATH}/host_vars/uat"
mkdir -p "${PROJECT_PATH}/host_vars/prd"
mkdir -p "${PROJECT_PATH}/inventories"
mkdir -p "${PROJECT_PATH}/roles"
# Use Ansible galaxy init to create a default 'common' role
ansible-galaxy init common --init-path="${PROJECT_PATH}/roles/"
touch "${PROJECT_PATH}/inventories/dev"
touch "${PROJECT_PATH}/inventories/uat"
touch "${PROJECT_PATH}/inventories/prd"
touch "${PROJECT_PATH}/${PLAYBOOK_TITLE}.yml"