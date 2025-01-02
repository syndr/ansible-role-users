users
=========

[![Role - users](https://github.com/syndr/ansible-role-users/actions/workflows/role-users.yml/badge.svg)](https://github.com/syndr/ansible-role-users/actions/workflows/role-users.yml)

Configure user accounts on the target machine.

This role uses Molecule for unit testing. To use the provided Molecule test scenario, run the following from the root of the `users` role directory:

```bash
molecule test -s role-users
```

Requirements
------------

None

Role Variables
--------------

This role requires a list of user definitions, as follows:

```yaml
# A list of user accounts to manage
# Each item supports the following attributes:
#   username: The username to create or manage
#   password: The password HASH for the user (optional, must be compatible with /etc/shadow)
#   comment: A comment to add to the user account (optional, for reference only)
#   expires: The date, in epoch time, that the account will expire (optional, default: never)
#   create_home: Whether to create the user's home directory (default: true)
#   state: The state of the user account (present or absent, default: present)
#   group: The primary group for the user (default: username)
#   groups: A list of additional groups for the user (default: [])
#           Groups will be created if they do not exist
#   admin: Whether the user should have sudo access for all commands (default: false)
#   shell: The user's shell (default: /bin/bash)
#   robot: Whether the user is a robot account (default: false)
#          Robot accounts default to a shell of /bin/false
#   generate_ssh_key: Whether to generate an SSH keypair for the user (default: false)
#   ssh_private_key: The private key to use for the user (optional, default: none)
#                    Do not store private keys in plain text!
#   ssh_key_type: The type of SSH key to generate (default: ed25519)
#   ssh_keys: A list of SSH public keys to enable for logon for this user (optional, default: [])
server_users:
  - username: ansible
    admin: true
    group: ansible
    shell: /bin/bash
    state: present
    ssh_keys:
      - "ssh-rsa blahblahpublickey"
  - username: support
    admin: true
    state: present
    ssh_keys:
      - "ssh-rsa blahblabhlaotherpublickey"
  - username: console
    admin: true
    state: present
    password: "{{ vault_user_console_password_hash }}"
  - username: myapp
    admin: false
    create_home: false
    shell: /bin/false
  - username: boogyman
    state: absent
```

Passwords must be hashed using a method compatible with `/etc/shadow` usage.

Required variables:
- `username`

Dependencies
------------

None

Example Playbook
----------------

```yaml
- name: Configure user accounts
  hosts: all
  tasks:
    - name: Load user configuration role
      ansible.builtin.include_role:
        name: users
      vars:
        server_users:
          - username: support
            admin: true
            state: present
            ssh_keys:
              - "ssh-rsa blahblabhlaotherpublickey"
```

License
-------

MIT

Author Information
------------------

- [@syndr](https://github.com/syndr)

