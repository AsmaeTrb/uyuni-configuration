install_packages:
  pkg.installed:
    - pkgs: {{ pillar.get('packages:common_install', []) }}
update_packages:
  pkg.latest:
    - pkgs: {{ pillar.get('packages:common_update',[]) }}
remove_packages:
  pkg.removed:
    - pkgs: {{ pillar.get('packages:common_remove',[]) }}
update_all_packages:
  pkg.uptodate: []

  
