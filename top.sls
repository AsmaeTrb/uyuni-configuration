base:
  'os:Debian':
    - match: grain
    - packages.common_debian
    - system.hostname
    - system.timezone
    - system.ntp_debian

  'os:Rocky':
    - match: grain
    - packages.common_rocky
    - system.hostname
    - system.timezone
    - system.ntp_rocky
