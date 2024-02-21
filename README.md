# Mahout -- A Kubernetes Operator for Mastodon

Mahout is a Kubernetes operator to deploy Mastodon nicely on your cluster. Mahout is written in OCaml.

Currently, Mahout supports Kubernetes 1.28 only.

## Quick Start

Install Mahout via Helm.

```
helm install --namespace mahout mahout ../charts/mahout/
```

Create and apply a `Mastodon` resource for your server:
```
---
apiVersion: mahout.anqou.net/v1alpha1
kind: Mastodon
metadata:
  name: mastodon
spec:
  serverName: "mastodon.example"
  image: "ghcr.io/mastodon/mastodon:v4.2.0"
  envFrom:
    - secretRef:
        # Define necessary Mastodon's environment vairables such as LOCAL_DOMAIN.
        name: secret-env
```
Mahout will then start the necessary migration jobs and deployments for nginx, web, streaming, and sidekiq.

When upgrading Mastodon, all you need to do is edit the `image` field in the `Mastodon` resource.
Mahout will take care of the necessary DB migrations and roll out the new deployments.

## License

- `charts/mahout/templates/gateway-nginx-conf-template.yaml`
  - A fork of Mastodon's `dist/nginx.conf`. See the file for the details.

The rest of the files are licensed under AGPL-3.0:

```
Mahout -- A Kubernetes Operator for Mastodon
Copyright (C) 2024 Ryotaro Banno

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see http://www.gnu.org/licenses/.
```
