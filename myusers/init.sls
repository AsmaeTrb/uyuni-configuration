{% for grp in pillar.get('groups', {}).get('common_groups', []) %}
group_{{ grp }}:
  group.present:
    - name: {{ grp }}
{% endfor %}

{% for username, udata in pillar.get('users', {}).get('common_users', {}).items() %}
{% set user_groups = udata.get('groups', []) %}
user_{{ username }}:
  user.{{ udata.get('state', 'present') }}:
    - name: {{ username }}
    - shell: {{ udata.get('shell', '/bin/bash') }}
    - password: {{ udata.get('password', '') }}
    - groups:
{% for grp in user_groups %}
      - {{ grp }}
{% endfor %}
    - require:
{% for reqgrp in user_groups %}
      - group: group_{{ reqgrp }}
{% endfor %}
{% endfor %}
