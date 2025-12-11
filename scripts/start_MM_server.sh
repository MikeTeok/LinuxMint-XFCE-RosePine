#!/bin/bash

(PYTHONPATH=~/Documents/PyCharmProjects/MengMeng ~/Documents/PyCharmProjects/MengMeng/.venv/bin/gunicorn --threads 4 -w 1 -b 0.0.0.0:5000 webapp:app) &
(ngrok http --url=selected-loving-puma.ngrok-free.app 5000)
