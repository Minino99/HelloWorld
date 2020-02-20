#!/bin/bash

# lint
for i in `ls -1 src/*.php`; do php -l $i; done;

# libraries
composer install

