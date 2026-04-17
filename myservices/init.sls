include:
  - mypackages
  - myconfigs
{%- for srv in salt['pillar.get']('services_common:running', []) %}
service_common_running_{{ srv }}:
  service.running:
    - name: {{ srv }}
    - enable: True
    - require:
      - sls: mypackages
      - sls: myconfigs
   {%- if srv in salt['pillar.get']('services_common:watch',{}) %}
    - watch:
      - file: {{ salt['pillar.get']('services_common:watch:'~ srv )}}
  {%- endif %}
     
{%- endfor %}

{%- for srv in salt['pillar.get']('services_common:dead', []) %}
service_common_dead_{{ srv }}:
  service.dead:
    - name: {{ srv }}
    - enable: False
{%- endfor %}

{%- for srv in salt['pillar.get']('services_os:running', []) %}
service_os_running_{{ srv }}:
  service.running:
    - name: {{ srv }}
    - enable: True
  {%- if srv in salt['pillar.get']('services_os:watch',{}) %} 
    - watch:
      - file: {{ salt['pillar.get']('services_os:watch:'~ srv) }}
  {%- endif %}
{%- endfor %}
{%- for srv in salt['pillar.get']('services_os:dead', []) %}
service_os_dead_{{ srv }}:
  service.dead:
    - name: {{ srv }}
    - enable: False
{%- endfor %}
{%- for srv in salt['pillar.get']('services_host:running', []) %}
service_host_running_{{ srv }}:
  service.running:
    - name: {{ srv }}
    - enable: True
  {%- if srv in salt['pillar.get']('services_host:watch',{}) %}
    - watch:
      - file: {{ salt['pillar.get']('services_host:watch:'~ srv) }}
  {%- endif %}
{%- endfor %}
