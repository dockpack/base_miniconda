# Ansible Role: Miniconda
[![Galaxy](https://img.shields.io/badge/galaxy-dockpack.base__miniconda-blue.svg?style=flat)](https://galaxy.ansible.com/dockpack/base_miniconda)
[![Build Status](https://travis-ci.com/dockpack/base_miniconda.svg?branch=master)](https://travis-ci.org/dockpack/base_miniconda)

Installs [Miniconda](https://conda.io/miniconda.html) on Debian-based and RedHat-based Linux distributions. Miniconda is the minimal version of [Anaconda](https://www.anaconda.com/distribution/), a cross-platform Python distribution with a built-in environment and package manager. This role has an ansible module by @evandam to manage miniconda environments in an idempotent way..

Install this role using `ansible-galaxy`:

```bash
ansible-galaxy install dockpack.base_miniconda
```

## Requirements

Python.

## Development

This role is tested with tox and molecule test on Travis.

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
miniconda_ver: "4.7.12"

# miniconda checksums
miniconda_checksums:
  Miniconda2-4.7.12-Linux-x86_64.sh: "md5:5a218d9dce3a77905d17ae87ac72a1e8"
  Miniconda3-4.7.12-Linux-x86_64.sh: "md5:0dba759b8ecfc8948f626fa18785e3d8"

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
    miniconda_envs:
      - pyenv: "{{ miniconda_dir }}/envs/py27"
        python: "2.7"
      - pyenv: "{{ miniconda_dir }}/envs/py37"
        python: "3.7"
    miniconda_packages:
      - future
      - pytest
      - pandas
      - numpy
      - scipy
      - matplotlib
    miniconda_channels:
      - main
      - conda-forge

  roles:
    - role: base_miniconda


  tasks:
    - name: Create conda environments
      conda:
        executable: "{{ miniconda_dir }}/bin/conda"
        name: "python={{ item.python }}"
        environment: "{{ item.pyenv }}"
      with_items: "{{ miniconda_envs }}"

    - name: Configure conda environments
      conda:
        executable: "{{ miniconda_dir }}/bin/conda"
        environment: "{{ item.pyenv }}"
        channels: "{{ miniconda_channels }}"
        name: "{{ miniconda_packages }}"
        state: present
      with_items: "{{ miniconda_envs }}"

```

## License

MIT
