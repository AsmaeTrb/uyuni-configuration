{%- for jobname, udata in salt['pillar.get']('crons_host:job', {}).items() %}
cron_{{ jobname }}:
  cron.{{ udata.get('state', 'present') }}:
    - name: {{ udata.get('job', '') }}
    - user: {{ udata.get('user', 'root') }}
    - minute: '{{ udata.get('minute', '0') }}'
    - hour: '{{ udata.get('hour', '*') }}'
    - daymonth: '{{ udata.get('daymonth', '*') }}'
    - month: '{{ udata.get('month', '*') }}'
    - dayweek: '{{ udata.get('dayweek', '*') }}'
{%- endfor %}
