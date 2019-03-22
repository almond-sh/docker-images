#!/usr/bin/env bash

export SCALA212_VERSION="$(grep -oP '(?<=def scala212 = ")[^"]*(?<!")' almond/project/Settings.scala)"
export SCALA211_VERSION="$(grep -oP '(?<=def scala211 = ")[^"]*(?<!")' almond/project/Settings.scala)"
export ALMOND_VERSION="$(git -C almond describe --tags --abbrev=0 --match 'v*' | sed 's/^v//')"
