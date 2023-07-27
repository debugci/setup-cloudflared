# Setup Cloudflare Tunnel client

🚛 Installs `cloudflared` for GitHub Actions

<div align="center">

![](https://github.com/ttyci/setup-cloudflared/assets/61068799/4f6bbf6b-197e-401a-a1b2-2c7fb5a6e31f)

</div>

🚀 Downloads & installs the `cloudflared` binary \
0️⃣ Zero-config &mdash; just add `uses: ttyci/setup-cloudflared@v1` \
⚠️ Only _installs_ `cloudflared` &mdash; it's on you to use it \
🌈 Works on Windows, macOS, and Linux runners

## Usage

![GitHub Actions](https://img.shields.io/static/v1?style=for-the-badge&message=GitHub+Actions&color=2088FF&logo=GitHub+Actions&logoColor=FFFFFF&label=)
![GitHub](https://img.shields.io/static/v1?style=for-the-badge&message=GitHub&color=181717&logo=GitHub&logoColor=FFFFFF&label=)

This action will **download and install** the [Cloudflare Tunnel client
(formerly Argo Tunnel)] for GitHub Actions. To use it, all you need to do is add
the following `uses:` block to your GitHub Actions steps. It even works on
Windows runners!

```yml
- uses: ttyci/setup-cloudflared@v1
```

Then after setting up your `cloudflared` installation with that action 👆 you
can use the `cloudflared` binary anywhere in your program. For example, if
you're manually testing some kind of web service inside of GitHub Actions, you
may want to expose that via [Cloudflare Quick Tunnels]

```yml
# Starts a background process that will run EVEN AFTER this step completes.
# This is what you want if you're hosting a temp HTTP server in GitHub Actions.
- run: nohup cloudflared tunnel --url http://localhost:5000 &
```

📚 You can read more about all of the features of [the Cloudflare Tunnel client]
on their [documentation website].

<details><summary>Here's an example of <code>npx serve</code> being exposed to the world via <code>cloudflared</code> using GitHub Actions</summary>

```yml
on: workflow_dispatch
jobs:
  npx-serve:
    runs-on: ubuntu-latest
    steps:
      - uses: ttyci/setup-cloudflared@v1
      - run: |
          npx -y serve &
          cloudflared tunnel --url http://localhost:3000 &
          echo 'To stop the server, click CANCEL in the workflow/job'
          wait -n
```

</details>

### Options

There's only one option so far. If you want to see automatic login or similar,
just open an Issue! ❤️

- **`cloudflared-version`:** Specifies which version of the `cloudflared` binary
  to install from the GitHub Releases page. Note that this is not your typical
  `v1.2.3` version string; instead Cloudflare uses a `v2023.1.1` date-based
  versioning scheme. The default value for this field is `latest` which will
  automagically default to the latest GitHub Release.

## Development

![GNU Bash](https://img.shields.io/static/v1?style=for-the-badge&message=GNU+Bash&color=4EAA25&logo=GNU+Bash&logoColor=FFFFFF&label=)

This GitHub Action is relatively simple. As such, it's currently Bash-based to
keep things simple. To test the action, we use GitHub Actions
(actions-ception!). To get started, just fork/clone the repo and make a PR! All
PRs automatically run various use examples to make sure that the action "works"
for basic stuff.

<!-- prettier-ignore-start -->
[Cloudflare Tunnel client (formerly Argo Tunnel)]: https://github.com/cloudflare/cloudflared#readme
[the cloudflare tunnel client]: https://github.com/cloudflare/cloudflared#readme
[documentation website]: https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/install-and-setup/tunnel-guide/local/
[cloudflare quick tunnels]: https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/do-more-with-tunnels/trycloudflare/
<!-- prettier-ignore-end -->
