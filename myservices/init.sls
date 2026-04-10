enable_services:
  service.enabled:
    - names: {{ pillar.get('services:common_enable', [])}}
running_services:
  service.running:
    - names: {{ pillar.get('services:common_running', [])}}
    - enable: True
    - require:
      - sls: mypackages 
      - sls: myconfigs
disable_services:
  service.disabled:
    - names: {{ pillar.get('services:common_disable', [])}}
dead_services:
  service.dead:
    - names: {{ pillar.get('services:common_dead', [])}}
