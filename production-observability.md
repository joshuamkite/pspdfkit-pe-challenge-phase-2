# Production Observability

- [Production Observability](#production-observability)
  - [Overview](#overview)
  - [What comes as (almost!) standard](#what-comes-as-almost-standard)
  - [Application level monitoring](#application-level-monitoring)
  - [Other tools for observability](#other-tools-for-observability)
  - [Networking and security](#networking-and-security)
  - [Alerting and Notifications](#alerting-and-notifications)
  - [What to monitor](#what-to-monitor)
  - [My own suggestions](#my-own-suggestions)

## Overview

Given the direction of the brief to create a web app with deployment to Kubernetes, the following is written in this context. The 'classical' approach to observability focusses on 'the 3 pillars' of metrics, logging and traces. Although not everyone follows this school, e.g. Charity Majors, leader at Honeycomb (a company producing a product for integrating observability across the entire stack for an application). Logging helps with debugging, metrics track system performance, and tracing tracks request flows, making it easier to spot bottlenecks.

## What comes as (almost!) standard

The 'standard' observability stack on Kubernetes would use Prometheus and Grafana. Prometheus is the primary supported tool for collecting metrics and includes a database for that can be used for analysing results over time. Retention is typically within the cluster and typically configured to be relatively short lived. Prometheus can discover services, pods, etc through the K8s APIs automatically and so it's an easy on ramp for the 'cluster's' view of what's happening. Prometheus can also be used for alerting on conditions evaluations such as service down, CPU etc.

Grafana links in well with prometheus, although it also supports many other data sources, and is a visual dashboarding tool supporting charts, graphs, etc. It may also be used for alerting and notifications. Dashboards can be managed in code, e.g. with Terraform, for consistency.

If you are suing a Cloud platform then you will by definition have some involvement with CloudWatch/Google Cloud Monitoring/ Azure Monitor. These 'can' do some things, e.g. if you use Crossplane or other controllers to have the cluster manage external entities, but they tend not to have the full detail of the k8s-native tools or the multi account/project/subscription wide view of the outboard tools.

## Application level monitoring

As well as Honeycomb libraries and DataDog agents, there are also options such as the Prometheus Go client library to integrate application level monitoring into the cluster. With Open Telemetry agents it is possible to instrument applications to talk to a variety of possible aggregators for observability. 

## Other tools for observability  

There are many other tools that may be used depending on preference, e.g.  DataDog as an outboard service for instance can give a view across multiple clusters down to agents within containers in app pods. DataDog, like its competitors, isn't cheap but it's excellent for getting a wide view quickly, aggregating from multiple sources to give a coherent picture. As a platform engineer I have found it excellent for its quick onboarding for people at a variety of technical levels and good support for configuration in code etc. as well as a good base for alerting and notifications. I would certainly nominate it for consideration. Datadog can e.g. integrate consumption from CloudWatch and kubernetes agents to give a full picture across a cluster.

## Networking and security

It is possible to enforce networking rules and monitor with a service mesh such as LinkerD for traffic insights, retries, circuit breaking, etc.  permissions and policies can be monitored with tools such as Kyverno. These take more commitment to employ and really need consensus support to be beneficial in my view. Prometheus and Grafana can consume service mesh data, making them a powerful combination for network observability.

## Alerting and Notifications

Although many, if not all, of the tools described above support alerting and notifications, they do so by sending those 'somewhere', e.g. email/Slack/Teams. This can be sufficient for day to day work but for critical stuff it is better to look at dedicated platforms such as PagerDuty or Incident.io for tiered an repeated alerting across multiple channels, automatic ticket and channel creation etc. I have more experience with PagerDuty but what I have seen of Incident.io has been impressive.

##  What to monitor

For developers I would want to support what was important to them, e.g. tagging by release version etc. 

For myself and my users I would want to know that my cluster was up, my services were up, etc. It's important to monitor both infrastructure and application-specific metrics. Infrastructure metrics include CPU usage, memory consumption, pod restarts, and service availability. For the web app, I would track request rates, error rates (e.g., HTTP 4xx/5xx), and request latency percentiles (e.g., 95th percentile). Additionally, logging response times by release version or region helps track regressions and identify performance issues early.

Synthetic tests and Real User Monitoring (RUM) can complement standard monitoring, allowing for proactive checks on system availability before customers experience issues. These can be set up with tools like DataDog’s Synthetic Monitoring or Grafana’s Synthetic Monitoring plugins.

## My own suggestions

- Prometheus and Grafana for in-cluster metrics and visualizations with at least a basic working configuration as a 'common point of entry'.
- Cloudwatch or equivalent for a cloud service is presumed for some components, especially delegated resources.
- DataDog or a similar tool if the organization supports it.
- PagerDuty or Incident.io for robust on-call alerting.
- For deep tracing, tools like Jaeger or OpenTelemetry may be worth exploring to get insights into distributed systems although I personally have less experience with these. 
- Honeycomb might be an alternative to consider in coordination with application development.