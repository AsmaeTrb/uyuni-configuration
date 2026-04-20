fail2ban_jail_local:
  file.managed:
    - name: /etc/fail2ban/jail.local
    - source: salt://mysecurity/files/jail.local.j2
    - template: jinja
    - mode: '0644'
    - user: root
    - group: root
    - require:
      - sls: mypackages
