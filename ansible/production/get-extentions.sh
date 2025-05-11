#!/bin/bash

curl -X POST --data-binary @talos-extensions.yaml https://factory.talos.dev/schematics
