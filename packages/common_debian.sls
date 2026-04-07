# outils de base
common_tools_debian:
  pkg.installed:
    - pkgs:
      - htop
      - curl
      - dnsutils

# nginx seul
install_nginx:
  pkg.installed:
    - name: nginx

common_remove_debian:
  pkg.removed:
    - pkgs:
      - htop
      - curl 
      - dnsutils
common_update_debian:
  pkg.latest:
    - name: openssl
configure_nginx:
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source: salt://nginx/nginx.conf
    - require:
      - pkg: install_nginx
nginx_service:
  service.running:
    - name: nginx
    - enable: true
    - reload: true
    - require: 
      - pkg: install_nginx
    - watch:
      - file: configure_nginx

ssh_service:
  service.running:
      - name: ssh
      - enable: true
      - reload: false   
