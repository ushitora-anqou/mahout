# Mahout -- A Kubernetes Operator for Mastodon

Mahout is a Kubernetes operator to deploy Mastodon nicely on your cluster. Mahout is written in OCaml.

Currently, Mahout supports Kubernetes 1.28 only.

## Quick Start

Install Mahout via Helm.

```
helm install --namespace mahout --repo https://ushitora-anqou.github.io/mahout mahout mahout
```

Create and apply a `Mastodon` resource for your server:
```yaml
apiVersion: mahout.anqou.net/v1alpha1
kind: Mastodon
metadata:
  name: mastodon
spec:
  serverName: "mastodon.example"
  image: "ghcr.io/mastodon/mastodon:v4.2.0" # Change here to the latest version
  envFrom:
    - secretRef:
        # Define necessary Mastodon's environment vairables such as LOCAL_DOMAIN.
        name: secret-env
  gateway:
    image: nginx:1
```
Mahout will then start the necessary migration jobs and deployments for nginx, web, streaming, and sidekiq.

When upgrading Mastodon, all you need to do is edit the `image` field in the `Mastodon` resource.
Mahout will take care of the necessary DB migrations and roll out the new deployments.

## Features & Tips

- You can restart mastodon-web pods on a regular schedule by using the `periodicRestart` field. [See this test manifest](https://github.com/ushitora-anqou/mahout/blob/d8abd2c92a27064f6f4c3567548582b7992ae124/e2e/manifests/mastodon0-v4.2.0-restart.yaml#L30-L31) for details.
- You can add your favourite annotations to the pods. [See this test manifest](https://github.com/ushitora-anqou/mahout/blob/d8abd2c92a27064f6f4c3567548582b7992ae124/e2e/manifests/mastodon0-v4.2.0-restart.yaml#L28-L29). This feature is especially useful in combination with [stakater/Reloader](https://github.com/stakater/Reloader) to reload configmaps and secrets specified in the Mastodon resources.
- Mahout can work across namespaces, i.e. you can run Mahout in one namespace, and create Mastodon resources in another. Of course you can also put them in the same namespace.

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
