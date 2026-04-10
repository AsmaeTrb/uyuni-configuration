deploy_ssh_config:
  file.managed:
    - name: /etc/ssh/sshd_config
    - source: salt://myconfigs/files/sshd_config.j2
    - template: jinja
    - user: root
    - group: root
    - mode: '600'
    - require:
      - sls: mypackages
set_hostname_config:
  file.managed: 
    - name: /etc/hostname
    - contents: |
        {{ pillar['system']['hostname'] }}
apply_hostname_config:
  cmd.run:
    - name: hostnamectl set-hostname {{ pillar['system']['hostname'] }}
    - onchanges:
      - file: set_hostname_config
set_timezone:
  timezone.system:
    - name: {{ pillar['timezoneset']['timezone'] }}
