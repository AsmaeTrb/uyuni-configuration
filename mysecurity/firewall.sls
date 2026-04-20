include:
  - mypackages
{%- if grains['os_family'] == 'Debian' %}
{%- for port in salt['pillar.get']('firewall_common:allow', []) %}
ufw_allow_{{ port }}:
  cmd.run:
    - name: ufw allow {{ port }}/tcp
{%- endfor %}

{%- for port in salt['pillar.get']('firewall_os:allow', []) %}
ufw_allow_{{ port }}:
  cmd.run:
    - name: ufw allow {{ port }}/tcp
{%- endfor %}

{%- for port in salt['pillar.get']('firewall_host:allow', []) %}
ufw_allow_{{ port }}:
  cmd.run:
    - name: ufw allow {{ port }}/tcp
{%- endfor %}
{%- for port in salt['pillar.get']('firewall_common:deny', []) %}
ufw_deny_{{ port }}:
  cmd.run:
    - name: ufw deny {{ port }}/tcp
{%- endfor %}

{%- for port in salt['pillar.get']('firewall_os:deny', []) %}
ufw_deny_{{ port }}:
  cmd.run:
    - name: ufw deny {{ port }}/tcp
{%- endfor %}
{%- for port in salt['pillar.get']('firewall_host:deny', []) %}
ufw_deny_{{ port }}:
  cmd.run:
    - name: ufw deny {{ port }}/tcp
{%- endfor %}
ufw_enable:
  cmd.run:
    - name: ufw --force enable
    - require:
      - sls: mypackages
{%- elif grains['os_family']== 'RedHat' %}
{%- for port in salt['pillar.get']('firewall_os:allow', []) %}
firewalld_allow_{{ port }}:
  cmd.run:
    - name: firewall-cmd --permanent --add-port={{ port }}/tcp
{%- endfor %}

{%- for port in salt['pillar.get']('firewall_host:allow', []) %}
firewalld_allow_{{ port }}:
  cmd.run:
    - name: firewall-cmd --permanent --add-port={{ port }}/tcp
{%- endfor %}
{%- for port in salt['pillar.get']('firewall_common:allow', []) %}
firewalld_allow_{{ port }}:
  cmd.run:
    - name: firewall-cmd --permanent --add-port={{ port }}/tcp
{%- endfor %}

{%- for port in salt['pillar.get']('firewall_common:deny', []) %}
firewalld_deny_{{ port }}:
  cmd.run:
    - name: firewall-cmd --permanent --remove-port={{ port }}/tcp
{%- endfor %}

{%- for port in salt['pillar.get']('firewall_os:deny', []) %}
firewalld_deny_{{ port }}:
  cmd.run:
    - name: firewall-cmd --permanent --remove-port={{ port }}/tcp
{%- endfor %}
{%- for port in salt['pillar.get']('firewall_host:deny', []) %}
firewalld_deny_{{ port }}:
  cmd.run:
    - name: firewall-cmd --permanent --remove-port={{ port }}/tcp
{%- endfor %}
firewalld_reload:
  cmd.run:
    - name: firewall-cmd --reload
    - require:
      - sls: mypackages
{%- endif %}
