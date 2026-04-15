{%- for grp in salt['pillar.get']('groups_common:group', []) %}
group_{{grp}}:
  group.present:
    - name: {{grp}}
{%- endfor %}
{%- for grp in salt['pillar.get']('groups_host:group', []) %}
group_{{grp}}:
  group.present:
    - name: {{grp}}
{%- endfor %}
{%- for grp in salt['pillar.get']('groups_os:group',[]) %}
group_{{ grp }}:
  group.present:
    - name: {{ grp }}
{%- endfor %}
{%- for username,udate in salt['pillar.get']('users_common:user', {}).items() %}
user_{{ username }}:
  user.{{ udate.get('state','present') }}:
    - name: {{ username }}
    - shell: {{ udate.get('shell','/bin/bash')}}
    - password: {{ udate.get('password','!')}}
    - groups: {{ udate.get('groups',[]) }}
    - require:
       {%- for grp in udate.get('groups',{}) %}
      - group: group_{{ grp }}
       {%- endfor %}
{%- for key in udate.get('ssh_keys',[]) %}
ssh_key_{{username}}_{{loop.index}}:
  ssh_auth.present:
    - user: {{ username }}
    - name: {{ key}}
{%- endfor %}
{%- if udate.get('sudo') %}
sudo_file_{{ username }}:
  file.managed:
    - name: /etc/sudoers.d/{{ username }}
    - contents: " {{ udate.get('sudo')}} "
    - mode: '0440'
{%- endif %}
{%- endfor %}
{%- for username,udate in salt['pillar.get']('users_host:user',{}).items() %}
user_{{ username }}:
  user.{{ udate.get('state','present')}}:
    - name: {{ username}}
    - shell: {{ udate.get('shell','/bin/bash') }}
    - password: {{ udate.get('password','')}}
    - groups: {{ udate.get('groups',[]) }}
    - require:
{%- for grp in udate.get('groups',{}) %}
      - group: group_{{ grp }}
{%- endfor %}
{%- for key in udate.get('ssh_keys',[]) %}
ssh_key_{{ username }}_{{loop.index}}:
  ssh_auth.present:
    - user: {{ username }}
    - name: {{ key}}
{%- endfor %}
{%- if udate.get('sudo') %}
sudo_file_{{username}}:
  file.managed:
   - name: /etc/sudoers.d/{{ username }}
   - contents: " {{ udate.get('sudo') }} "
   - mode: '0440'
{%- endif %}
{%- endfor %}
{%- for username,udate in salt['pillar.get']('users_os:user', {}).items() %}
user_{{ username }}:
  user.{{ udate.get('state','present') }}:
    - name: {{ username }}
    - shell: {{ udate.get('shell','/bin/bash')}}
    - password: {{ udate.get('password','!')}}
    - groups: {{ udate.get('groups',[]) }}
    - require:
       {%- for grp in udate.get('groups',{}) %}
      - group: group_{{ grp }}
       {%- endfor %}
{%- for key in udate.get('ssh_keys',[]) %}
ssh_key_{{username}}_{{loop.index}}:
  ssh_auth.present:
    - user: {{ username }}
    - name: {{ key}}
{%- endfor %}
{%- if udate.get('sudo') %}
sudo_file_{{ username }}:
  file.managed:
    - name: /etc/sudoers.d/{{ username }}
    - contents: " {{ udate.get('sudo')}} "
    - mode: '0440'
{%- endif %}
{%- endfor %}
