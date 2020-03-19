first-playbook:
	ansible-playbook -i inventories/dev -K first_playbook.yml

make-role:
	ansible-galaxy init $2 -init-path="roles/$2" --force


add-vault-password:
	ansible-vault create group_vars/dev/mysql.yml
	# this will open an editor
	# type this: mysql_root_password: <<ROOTPASSWORD>>

run-ansible-with-vault:
	ansible-playbook --ask-vault-pass -i inventories/dev -k first_playbook.yml