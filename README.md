<p align="center">
  <a href="https://deno.com"><img src="https://camo.githubusercontent.com/3bd1addadda204b1103c7989b704101b8c31d0760f803c72c93f805ff502012b/68747470733a2f2f64656e6f2e6c616e642f6c6f676f2e737667" alt="Logo" height=170></a>
</p>
<h1 align="center">Setup Deno in Dev Containers</h1>

Download, install, and setup specific version of [Deno](https://deno.com/) in your Dev Container.


## Quick Start

[![Open a Dev Container](https://img.shields.io/static/v1?style=for-the-badge&label=Dev+Container&message=Open&color=blue&logo=visualstudiocode)](https://vscode.dev/redirect?url=vscode://ms-vscode-remote.remote-containers/cloneInVolume?url=https://github.com/alertbox/try-docsify)

You can also add this feature to your `devcontainer.json` file.

```json filename="devcontainer.json"
"features": {
    "ghcr.io/alertbox/denoland/deno:1": {}
}
```
### Installing packages globally

You can also install packages globally, using the `packages` option. Typically this is used for installing CLI tools and the like.

```json filename="devcontainer.json"
"features": {
    "ghcr:io/alertbox/denoland/deno:1": {
        "packages": "jsr:@std/http/file-server"
    }
}
```

### Node.js not needed

You don't need to use the feature [node](https://github.com/devcontainers/features/tree/main/src/node#readme) in most cases.

## Options

See [src/deno](./src/deno/README.md) folder to learn more about options.


## Contributing

The official repo to contribute would be [@denoland/deno](https://github.com/denoland/deno?tab=readme-ov-file#readme).

Have a suggestion or a bug fix? Just open a pull request or an issue. Include clear and simple instructions possible.

## License

Copyright (c) The Alertbox, Inc. (@alertbox). All rights reserved.

The source code is license under the [MIT license](#MIT-1-ov-file).
