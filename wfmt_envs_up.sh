#!/bin/bash

kubectl config use-context wfmt get pods

# -n postgres port-forward prod-db-2 5342:5438