# Ansible Role: Miniconda

[![Build Status](https://travis-ci.org/jkglasbrenner/ansible-role-miniconda.svg?branch=master)](https://travis-ci.org/jkglasbrenner/ansible-role-miniconda)

Installs [Miniconda](https://conda.io/miniconda.html) on Debian-based and RedHat-based distributions. Miniconda is the minimal version of [Anaconda](https://www.anaconda.com/distribution/), a cross-platform Python distribution with a built-in environment and package manager.

Install this role using `ansible-galaxy`:

```bash
# Install this role using ansible-galaxy
ansible-galaxy install jkglasbrenner.miniconda
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
miniconda_ver: "4.5.4"

# miniconda checksums
miniconda_checksums:
  Miniconda2-4.5.4-Linux-x86_64.sh: "md5:8a1c02f6941d8778f8afad7328265cf5"
  Miniconda3-4.5.4-Linux-x86_64.sh: "md5:a946ea1d0c4a642ddf0c3a26a18bb16d"

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

## Example Playbook

```yaml
- hosts: all
  roles:
    - jkglasbrenner.miniconda
```

## License

MIT
