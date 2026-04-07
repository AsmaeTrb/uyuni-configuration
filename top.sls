base:
  'os:Debian':
    - match: grain
    - packages.common_debian

  'os:Rocky':
    - match: grain
    - packages.common_rocky
