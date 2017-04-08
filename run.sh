#!/bin/sh

set -euf -o pipefail

erb -r json /fluentd/etc/fluent.conf.erb >/tmp/fluent.conf
exec fluentd -c /tmp/fluent.conf $@