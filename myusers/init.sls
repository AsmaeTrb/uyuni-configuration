{%- for grp in salt['pillar.get']('groups_common:group', []) %}
group_{{ grp }}:
  group.present:
    - name: {{ grp }}
{%- endfor %}
{%- for grp in salt['pillar.get']('groups_host:group', []) %}
group_{{ grp }}:
  group.present:
    - name: {{ grp }}
{%- endfor %}
{%- for grp in salt['pillar.get']('groups_os:group', []) %}
group_{{ grp }}:
  group.present:
    - name: {{ grp }}
{%- endfor %}
{%- for username, udata in salt['pillar.get']('users_common:user', {}).items() %}
user_{{ username }}:
  user.{{ udata.get('state', 'present') }}:
    - name: {{ username }}
    - shell: {{ udata.get('shell', '/bin/bash') }}
    - password: {{ udata.get('password', '!') }}
    - groups: {{ udata.get('groups', []) }}
    - require:
      {%- for grp in udata.get('groups', []) %}
      - group: group_{{ grp }}
      {%- endfor %}
{%- for key in udata.get('ssh_keys', []) %}
ssh_key_{{ username }}_{{ loop.index }}:
  ssh_auth.present:
    - user: {{ username }}
    - name: {{ key }}
    - require:
      - user: user_{{ username }}
{%- endfor %}
{%- if udata.get('sudo') %}
sudo_file_{{ username }}:
  file.managed:
    - name: /etc/sudoers.d/{{ username }}
    - contents: "{{ udata.get('sudo') }}"
    - mode: '0440'
    - require:
      - user: user_{{ username }}
{%- endif %}
{%- endfor %}
{%- for username, udata in salt['pillar.get']('users_host:user', {}).items() %}
user_{{ username }}:
  user.{{ udata.get('state', 'present') }}:
    - name: {{ username }}
    - shell: {{ udata.get('shell', '/bin/bash') }}
    - password: {{ udata.get('password', '') }}
    - groups: {{ udata.get('groups', []) }}
    - require:
      {%- for grp in udata.get('groups', []) %}
      - group: group_{{ grp }}
      {%- endfor %}
{%- for key in udata.get('ssh_keys', []) %}
ssh_key_{{ username }}_{{ loop.index }}:
  ssh_auth.present:
    - user: {{ username }}
    - name: {{ key }}
    - require:
      - user: user_{{ username }}
{%- endfor %}
{%- if udata.get('sudo') %}
sudo_file_{{ username }}:
  file.managed:
    - name: /etc/sudoers.d/{{ username }}
    - contents: "{{ udata.get('sudo') }}"
    - mode: '0440'
    - require:
      - user: user_{{ username }}
{%- endif %}
{%- endfor %}
{%- for username, udata in salt['pillar.get']('users_os:user', {}).items() %}
user_{{ username }}:
  user.{{ udata.get('state', 'present') }}:
    - name: {{ username }}
    - shell: {{ udata.get('shell', '/bin/bash') }}
    - password: {{ udata.get('password', '!') }}
    - groups: {{ udata.get('groups', []) }}
    - require:
      {%- for grp in udata.get('groups', []) %}
      - group: group_{{ grp }}
      {%- endfor %}
{%- for key in udata.get('ssh_keys', []) %}
ssh_key_{{ username }}_{{ loop.index }}:
  ssh_auth.present:
    - user: {{ username }}
    - name: {{ key }}
    - require:
      - user: user_{{ username }}
{%- endfor %}
{%- if udata.get('sudo') %}
sudo_file_{{ username }}:
  file.managed:
    - name: /etc/sudoers.d/{{ username }}
    - contents: "{{ udata.get('sudo') }}"
    - mode: '0440'
    - require:
      - user: user_{{ username }}
{%- endif %}
{%- endfor %}
