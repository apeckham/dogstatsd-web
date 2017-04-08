FROM fluent/fluentd

RUN gem install fluent-plugin-dogstatsd

ADD fluent.conf.erb /fluentd/etc/fluent.conf.erb
ADD run.sh /run.sh

ENTRYPOINT ["/run.sh"]