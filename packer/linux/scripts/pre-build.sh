#!/bin/bash

build_file_path=$BUILD_FILES_REMOTE_PATH
curl -L -v https://goss.rocks/install | sudo bash -x
mkdir -p $build_file_path