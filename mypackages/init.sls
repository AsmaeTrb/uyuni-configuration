install_packages:
  pkg.installed:
    - pkgs:
      {%- for pkg in salt['pillar.get']('packages_common:install', []) %}
      - {{ pkg }}
      {%- endfor %}
      {%- for pkg in salt['pillar.get']('packages_os:install', []) %}
      - {{ pkg }}
      {%- endfor %}
      {%- for pkg in salt['pillar.get']('packages_host:install', []) %}
      - {{ pkg }}
      {%- endfor %}

{%- set pkgs_update = salt['pillar.get']('packages_common:update', []) +
                      salt['pillar.get']('packages_os:update', []) +
                      salt['pillar.get']('packages_host:update', []) %}
{%- if pkgs_update %}
update_packages:
  pkg.latest:
    - pkgs:
      {%- for pkg in pkgs_update %}
      - {{ pkg }}
      {%- endfor %}
{%- endif %}

remove_packages:
  pkg.removed:
    - pkgs:
      {%- for pkg in salt['pillar.get']('packages_common:remove', []) %}
      - {{ pkg }}
      {%- endfor %}
      {%- for pkg in salt['pillar.get']('packages_os:remove', []) %}
      - {{ pkg }}
      {%- endfor %}
      {%- for pkg in salt['pillar.get']('packages_host:remove', []) %}
      - {{ pkg }}
      {%- endfor %}

update_all_packages:
  pkg.uptodate: []
