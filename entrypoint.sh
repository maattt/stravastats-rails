#!/bin/bash

rm -rf /app/tmp/*

rails db:prepare
rails s -b 0.0.0.0