FROM fluent/fluentd

RUN gem install fluent-plugin-dogstatsd

ADD fluent.conf /fluentd/etc/fluent.conf