# PSPDFKit PE Candidate Challenge

Attempts to meet the requirements of the brief below:

## Phase 1: Development & Release Artifacts

Create and automate the building of a Go web application to be distributed as a container, using
the following process:

1. Create a clean Github repository
2. Write a very basic HTTP web server application that simply listens on a port and prints
“Hello from PSPDFKit Engineer!” Nothing fancy or complicated. This doesn’t need to be
done from memory, it’s not a test of your development technique per se but rather a
basic level competency.
3. Create a Github Action exec a SAST, lint and then build (depending on your language of
choice).
4. Create a Github Action that, on each Github Repository Release, tests, builds, and
stores the binary (again, depending on your language of choice) as a release asset

## Phase 2: Containerization & CI/CD

Frequently deployment occurs in a repo other than the one in which development occurs,
prepare deployment and automate interaction in the following way:

1. Create a Dockerfile for the application created in Phase 1
2. Create an action which will containerize the released application and store it in a registry
(DockerHub, GHCR, whatever you like)
3. Create a kubernetes definition (Helm Chart, Kustomize, Raw YAML, whatever) that
would allow a simple ‘kubectl create ...’ to deploy the application

## Phase 3: Production Observability

Deployment is only the first part of an applications' lifecycle, in order to satisfy the needs of
customers it must be available and performant, which means it must be observable and
maintainable. Please write approx. 1 page to describe how you would personally go about
establishing logging, tracing, metrics collection, dashboarding, notifications, and alerting.
Emphasis on how you’d do it and why you’d choose certain solutions and how that all works to
satisfy the needs of your users and developers alike. Store this document as Markdown in the
repository.

When you are done, provide the links to the Phase 1 & 2 repositories. The challenge should
take between 30m to 3 hours, not more.