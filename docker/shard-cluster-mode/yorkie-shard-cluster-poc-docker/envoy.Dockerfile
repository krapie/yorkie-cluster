FROM envoyproxy/envoy:v1.19.0

COPY ./envoy-ring-hash-router.yaml /etc/envoy/envoy.yaml

ENTRYPOINT ["/usr/local/bin/envoy", "-c"]

CMD /etc/envoy/envoy.yaml
