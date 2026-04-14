{% set fw = pillar.get('security', {}).get('firewall', {}) %}
{% set backend = fw.get('backend', 'ufw') %}

include:
{% if backend == 'ufw' %}
  - mysecurity.ufw
{% else %}
  - mysecurity.iptables
{% endif %}
