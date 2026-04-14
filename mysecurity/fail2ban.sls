# 1. Installer fail2ban
install_fail2ban:
  pkg.installed:
    - name: fail2ban

# 2. Déployer jail.local
fail2ban_jail_local:
  file.managed:
    - name: /etc/fail2ban/jail.local
    - source: salt://mysecurity/files/jail.local.j2
    - template: jinja
    - mode: '0644'
    - user: root
    - group: root
    - require:
      - pkg: install_fail2ban

# 3. Démarrer le service
fail2ban_service:
  service.running:
    - name: fail2ban
    - enable: True
    - watch:
      - file: fail2ban_jail_local
