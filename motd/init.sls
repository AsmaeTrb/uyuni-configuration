deployer_motd:
  file.managed:
    - name: /etc/motd
    - contents: |
        =============================================
        Serveur gere automatiquement par Uyuni/Salt
        Projet PFE
        =============================================
    - user: root
    - group: root
    - mode: '0644'
