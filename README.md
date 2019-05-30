# Ansible Role: Miniconda

[![Build Status](https://travis-ci.org/dockpack/base_miniconda.svg?branch=master)](https://travis-ci.org/dockpack/base_miniconda)

Installs [Miniconda](https://conda.io/miniconda.html) on Debian-based and RedHat-based Linux distributions. Miniconda is the minimal version of [Anaconda](https://www.anaconda.com/distribution/), a cross-platform Python distribution with a built-in environment and package manager. This role has an ansible module by @evandam to manage miniconda environments.

Install this role using `ansible-galaxy`:

```bash
ansible-galaxy install dockpack.base_miniconda
```

## Requirements

None.

## Role Variables

Variables and default values:

```yaml
# miniconda package dependencies
miniconda_package_dependencies:
  - bzip2

# main miniconda download server
miniconda_mirror: "https://repo.continuum.io/miniconda"

# version of python (2|3)
miniconda_python_ver: 3

# miniconda version
miniconda_ver: "4.5.12"

# miniconda checksums
miniconda_checksums:
  Miniconda2-4.5.12-Linux-x86_64.sh: "md5:4be03f925e992a8eda03758b72a77298"
  Miniconda3-4.5.12-Linux-x86_64.sh: "md5:866ae9dff53ad0874e1d1a60b1ad1ef8"

# miniconda installer info
miniconda_name: "Miniconda{{ miniconda_python_ver }}-{{ miniconda_ver }}-Linux-x86_64"
miniconda_installer_sh: "{{ miniconda_name }}.sh"
miniconda_installer_url: "{{ miniconda_mirror }}/{{ miniconda_installer_sh }}"
miniconda_checksum: "{{ miniconda_checksums[miniconda_installer_sh] }}"

# when downloading the miniconda binary it might take a while
miniconda_timeout_seconds: 600

# where to install miniconda
miniconda_parent_dir: /opt
miniconda_etc_profile: /etc/profile.d
miniconda_dir: "{{ miniconda_parent_dir }}/miniconda"
miniconda_etc_profile_conda: "{{ miniconda_dir }}/etc/profile.d/conda"
miniconda_conda_bin: "{{ miniconda_dir }}/bin/conda"

# run update on base packages after install?
miniconda_pkg_update: true
```

## Example Playbooks

### Install Miniconda3

```yaml
---
- hosts: all
  vars:
    install_miniconda: true
    miniconda_dir: "{{ miniconda_parent_dir }}/conda"
  roles:
    - role: base_miniconda
```

### Use as Ansible module

```yaml
---
- name: Verify
  hosts: all

  vars:
    miniconda_dir: "/opt/conda"
    install_miniconda: false

  roles:
    - role: base_miniconda

  tasks:

    - name: Update conda to latest version
      conda:
        executable: "{{ miniconda_dir }}/bin/conda"
        name: conda
        state: latest

    - name: Install numpy
      conda:
        executable: "{{ miniconda_dir }}/bin/conda"
        name: numpy
        state: present

    - name: Install multiple packages
      conda:
        executable: "{{ miniconda_dir }}/bin/conda"
        name:
          - pandas
          - sqlalchemy
        state: present

    - name: Install doxygen from conda-forge
      conda:
        executable: "{{ miniconda_dir }}/bin/conda"
        name: doxygen
        channels: conda-forge
```

## License

MIT
