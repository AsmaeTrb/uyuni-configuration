set-hostname:
  file.managed:
    - name: /etc/hostname
    - contents: |
        {{ pillar[grains['id']]['hostname'] }}
apply-hostname:
  cmd.run:
    - name: hostnamectl set-hostname {{ pillar[grains['id']]['hostname']}}
    - onchanges:
        - file: set-hostname
