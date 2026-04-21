include:
  - mypackages
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
        {{ pillar.get('system', {}).get('hostname', grains['id']) }}
apply_hostname_config:
  cmd.run:
    - name: hostnamectl set-hostname {{ pillar.get('system', {}).get('hostname', grains['id']) }}
    - onchanges:
      - file: set_hostname_config
set_timezone:
  timezone.system:
    - name: {{ pillar.get('timezoneset', {}).get('timezone', 'UTC') }}
{%- if salt['pillar.get']('rsyslog_server:enabled', false) %}
rsyslog_server_config:
  file.managed:
    - name: /etc/rsyslog.d/server.conf
    - source: salt://myconfigs/files/rsyslog-server.conf.j2
    - template: jinja
    - mode: '0644'
    - user: root
    - group: root
    - require:
      - sls: mypackages
{%- else %}
rsyslog_client_config:
  file.managed:
    - name: /etc/rsyslog.d/client.conf
    - source: salt://myconfigs/files/rsyslog-client.conf.j2
    - template: jinja
    - mode: '0644'
    - user: root
    - group: root
    - require:
      - sls: mypackages
{%- endif %}
{%- if salt['pillar.get']('rsyslog_server:enabled') %}
create_remote_logdir:
  file.directory:
    - name: {{salt['pillar.get']('rsyslog_server:logdir','/var/log/remote')}}
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: True
 {%- endif %}
