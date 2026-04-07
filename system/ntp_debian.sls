installer_chrony:
  pkg.installed:
    - name : chrony
file_config:
  file.managed:
    - name: /etc/chrony/chrony.conf
    - source: salt://system/chrony.conf
    - require: 
       - pkg: installer_chrony
chrony-service:
  service.running:
    - name: chronyd
    - enable: True
    - reload: False
    - require:
       - pkg: installer_chrony
    - watch:
       - file: file_config
      
