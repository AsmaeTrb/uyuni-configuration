{%- for srv in salt['pillar.get']('services_common:running', []) %}
service_running_{{ srv }}:
  service.running:
    - name: {{ srv }}
    - enable: True
    - require:
      - sls: mypackages
      - sls: myconfigs
{%- endfor %}

{%- for srv in salt['pillar.get']('services_common:dead', []) %}
service_dead_{{ srv }}:
  service.dead:
    - name: {{ srv }}
    - enable: False
{%- endfor %}
{%- for srv in salt['pillar.get']('services_os:running', []) %}
service_running_{{ srv }}:
  service.running:
    - name: {{ srv }}
    - enable: True
{%- endfor %}
{%- for srv in salt['pillar.get']('services_common:dead', []) %}
service_dead_{{ srv }}:
  service.dead:
    - name: {{ srv }}
    - enable: True
{%- endfor %}


