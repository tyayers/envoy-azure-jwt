# envoy-azure-jwt
This repository shows a simple envoy configuration to validate Azure AD JWT tokens.

The file **config.yaml** configures envoy to do JWT token validation from a test Azure AD tenant and configured app audience. It is targeting a local service running on port 8080 to prevent additional latency from remote network hops.

## Run
You can run this proxy by installing [envoy](https://www.envoyproxy.io/docs/envoy/latest/start/install) for your OS or using the docker container.  This config file was created for envoy v1.21.0.

Then you can run the proxy like this:
```bash
envoy -c config.yaml
```

## Simple Load Tests
You can perform simple load tests either on a local envoy proxy, or in a docker environment.

I performed some basic tests with the tool [wrk2](https://github.com/giltene/wrk2) with a sample token, for example here for 4000rps over 30s.

```bash
wrk -H "Authorization: Bearer $TOKEN" -t12 -c100 -d30s -R4000 http://localhost:10000/
```

The results of the above test showed the amazing scalability of even a single envoy process, with average latency of 2.85ms.

```bash
Running 30s test @ http://localhost:10000/
  12 threads and 100 connections
  Thread calibration: mean lat.: 3.489ms, rate sampling interval: 10ms
  Thread calibration: mean lat.: 3.018ms, rate sampling interval: 10ms
  Thread calibration: mean lat.: 2.986ms, rate sampling interval: 10ms
  Thread calibration: mean lat.: 2.918ms, rate sampling interval: 10ms
  Thread calibration: mean lat.: 2.937ms, rate sampling interval: 10ms
  Thread calibration: mean lat.: 2.921ms, rate sampling interval: 10ms
  Thread calibration: mean lat.: 3.180ms, rate sampling interval: 10ms
  Thread calibration: mean lat.: 2.785ms, rate sampling interval: 10ms
  Thread calibration: mean lat.: 3.277ms, rate sampling interval: 10ms
  Thread calibration: mean lat.: 3.077ms, rate sampling interval: 10ms
  Thread calibration: mean lat.: 2.846ms, rate sampling interval: 10ms
  Thread calibration: mean lat.: 3.045ms, rate sampling interval: 10ms
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     2.85ms    5.15ms  58.66ms   93.23%
    Req/Sec   351.57    114.35     1.22k    74.95%
  119968 requests in 30.00s, 19.68MB read
Requests/sec:   3999.12
Transfer/sec:    671.78KB

```