include:
  - groups
create_admin_pfe:
  user.present:
    - name: admin_pfe
    - uid: 1500
    - gid: 1500
    - shell: /bin/bash
    - home: /home/admin_pfe
    - createhome: True
    - require:
      - sls: groups
