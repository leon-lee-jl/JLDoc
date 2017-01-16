# **JLDOC**
[![Build Status](https://travis-ci.com/leon-lee-jl/JLDoc.svg?token=vG87w6v3Qj2vBxp6ZULJ&branch=master)](https://travis-ci.com/leon-lee-jl/JLDoc)

This repository is the personal technical documentation made during my study and work. It records all important notes that should be remembered and reviewed. The document is rendered in html format, and built from markdown and restructure files by [sphinx](https://github.com/leon-lee-jl/JLDoc.git).


-----------------------------------
## Table of Content
- [**Prerequisites**](#prerequisites)
    - [*Python Packages*](#python-packages)
    - [*Build Tool*](#build-tool)
- [**Build Tasks**](#build-tasks)
    - [*Build Html*](#build-html)
    - [*Build Epub*](#build-epub)
- [**TODO**](#todo)

----------------------------------
## Prerequisites
### Python Packages
This repository uses sphinx to automatically build document. Some required python packages are required. Install the packages listed in requirements.txt.
```shell
pip3 install -r requirements.txt
```
### Build Tool
Gulp is used as a build tool to manage sources files and build restructure and markdown files to html pages. To build the document, you should install the gulp as global tool and some necessary plugins defined in packages.json file.

```shell
npm install gulp -g
```
Enter root directory of this repository, and make sure package.json file existed.
```
npm install
```

-----------------------
## Build Tasks
Several format of document output are supported, such as html, epub. Use the following command to build your desired documentation.

### Build Html
```
gulp build-html
```

### Build Epub
```
gulp build-epub
```

-----------------------
## TODO

- [ ] Convert markdown table to rst cvs-table
- [ ] Add Personal CSS
- [ ] Revise project contents
