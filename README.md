# Dockerfiles

This is where we collect utility dockerfiles, i.e. docker images used only in CI
or development environments, _not_ applications we deploy to prod.

Each directory contains the build for one docker image, including the
`Dockerfile`, a file specifying the `VERSION`, and anything else needed for the
build. We use this `VERSION` file to tag the built docker image.

```
t@antimony> tree redis-cell
redis-cell
├── Dockerfile
├── redis.conf
└── VERSION # 0.1
```

If there are multiple "latest" versions of the docker image, you can create
subdirectories, each with their own VERSION file. The subdirectory names are not
used for tagging the image.

```
t@antimony> tree rust-ubuntu
rust-ubuntu
├── base-runtime
│   ├── Dockerfile
│   └── VERSION # base-runtime
├── openssl
│   ├── Dockerfile
│   └── VERSION # 1.46-openssl-1.1
├── ruby-capnp
│   ├── Dockerfile
│   └── VERSION # 1.46-ruby-capnp
└── rustc
    ├── Dockerfile
    └── VERSION # 1.46
```

## Deploying

There is no CI integration (yet). Deploy your images manually.

**To push a new tag, remember to update the VERSION file.**

```
# Update Dockerfile
vim <image>/Dockerfile

# Bump VERSION
vim <image>/VERSION

# Pass a directory name to deploy only one image.
script/deploy redis-cell

# Deploy all files... you probably don't want to do this?
script/deploy
```

## Adding New Images

- Create a Docker Hub repo under the osig organization _matching your directory
  name_. Only organization owners can create new repos.
- Create a new directory for your image.
- Add `Dockerfile`, `VERSION`, and anything else your build needs.
- `script/deploy` should now be able to deploy the new image.
