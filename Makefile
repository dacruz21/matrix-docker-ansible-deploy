.PHONY: setup start decrypt encrypt decrypt-password
.DEFAULT_GOAL := setup

PLAYBOOK=setup.yml
INVENTORY=inventory/hosts
SECRETS=inventory/host_vars/matrix.typokign.com/vars.yaml

setup:
	ANSIBLE_NOCOWS=1 ansible-playbook $(PLAYBOOK) -i $(INVENTORY) -K --tags=setup-all --vault-password-file=vault_password

start:
	ANSIBLE_NOCOWS=1 ansible-playbook $(PLAYBOOK) -i $(INVENTORY) -K --tags=start --vault-password-file=vault_password

decrypt:
	ansible-vault decrypt $(SECRETS) --vault-password-file=vault_password

encrypt:
	ansible-vault encrypt $(SECRETS) --vault-password-file=vault_password

decrypt-password:
	gpg --output vault_password --decrypt vault_password.gpg
