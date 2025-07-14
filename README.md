# nixpkgs-update-gha

Run your own @r-ryantm on GitHub's CI and skip the queue!

## Instructions

1. Fork `nixpkgs` to the account you'll be using, ideally under `<login>/nixpkgs`
2. Select "Use this template" and follow the prompts to make a copy of this repository
3. Create a classic access token with the `public_repo`, `read:user`, and `user:email` scopes, and store it under repository secrets as `GH_PAT`
4. Open the `.github/workflows/nixpkgs-update.yml` workflow and add your packages to `jobs.update-package.strategy.matrix.package`
