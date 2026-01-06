#!/bin/bash

if [[ -v OPTIONAL_APPS ]]; then
	apps=$OPTIONAL_APPS

	if [[ -n "$apps" ]]; then
		for app in $apps; do
			source "${UBUNTU_SETUP_DIR}/apps/optional/app_${app,,}.sh"
		done
	fi
fi
