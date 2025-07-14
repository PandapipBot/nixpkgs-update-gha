# nixpkgs-update-gha

Run your own @r-ryantm on GitHub's CI and skip the queue!

## Instructions

1. Fork `nixpkgs` to the account you'll be using, ideally under `<login>/nixpkgs`
2. Select "Use this template" and follow the prompts to make a copy of this repository
3. Either:
    - Create a classic access token with the `public_repo`, `workflow`, `read:user`, and `user:email` scopes
    - Create a fine-grained token with write access to this repository and the `nixpkgs` fork; and read and write workflows, read and write pull requests, and read email addresses permissions
4. Store the token under repository secrets as `GH_PAT`
5. Open the `.github/workflows/nixpkgs-update.yml` workflow and add your packages to `jobs.update-package.strategy.matrix.package`
