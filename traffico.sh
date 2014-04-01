#!/bin/sh

tail -f /var/log/nginx/access.log | ./estrai-traffico.pl | ./parsa-traffico.pl 
