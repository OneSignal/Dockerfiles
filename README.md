# Dockerfiles

This is where we collect utility dockerfiles, i.e. docker images used only in CI
or development environments, _not_ applications we deploy to prod.

Each directory contains the build for one docker image, including the
`Dockerfile`, a file specifying the `VERSION`, and anything else needed for the
build.

```
t@antimony> tree redis-cell
redis-cell
├── Dockerfile
├── redis.conf
└── VERSION
```

## Deploying

There is no CI integration (yet). Deploy your images manually.

**To bump the version, remember to update the VERSION file.**

```
# Deploy all files
script/deploy

# Pass a directory name to deploy only one image.
script/deploy redis-cell
```

Docker images are automatically tagged with the current git hash.

## Adding New Images

- Create a Docker Hub repo under the osig organization _matching your directory
  name_. Only organization owners can create new repos.
- Create a new directory for your image.
- Add `Dockerfile`, `VERSION`, and anything else your build needs.
- `script/deploy` should now be able to deploy the new image.

# rust-ubuntu

rust-ubuntu images are versioned with the rust compiler version they package.
These images have their own `deploy.sh`
