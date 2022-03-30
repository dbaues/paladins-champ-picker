import configparser
from setuptools import find_packages, setup
from typing import List


def read_pipfile(section) -> List[str]:
    packages = []
    config = configparser.ConfigParser()
    config.read('Pipfile')
    if not config.has_section(section):
        return packages
    for key in config[section]:
        version = config[section][key]
        if '==' not in version:
            packages.append(key)
        else:
            packages.append(f'{key}{version}'.replace('"', ''))
    return packages


setup(
    description='paladins-champ-picker',
    entry_points={
        'console_scripts': [
            'main = src.app:main',
        ]
    },
    install_requires=read_pipfile('packages'),
    name='paladins-champ-picker',
    packages=find_packages('.', exclude=('tests',)),
    tests_require=read_pipfile('packages') + read_pipfile('dev-packages')
)