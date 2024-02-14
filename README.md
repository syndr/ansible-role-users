users
=========

Configure user accounts on the target machine.

Requirements
------------

N/A

Role Variables
--------------

This role requires a list of user definitions, as follows:

```yaml
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

- Vincent Oltion ([@syndr](https://github.com/syndr/))

