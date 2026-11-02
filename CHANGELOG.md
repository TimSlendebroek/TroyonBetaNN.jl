# TroyonBetaNN (TimSlendebroek fork) changelog

This fork is part of the FUSE design stack (see github.com/TimSlendebroek/FUSE_Design.jl). Versions are
`<upstream version at the split>+design.<n>`; they satisfy the same compat bounds as the upstream version and never
clash with upstream release numbers. Releases are git tags `v<version>`.

## 1.1.0+design.1 (2026-11-02, branch `lean-deps`)

Upstream v1.1.0 plus:

- Sample-point plotting moved into a Plots extension (`ext/TroyonBetaNNPlotsExt.jl`): TroyonBetaNN loads without
  Plots; `verbose` warns instead of plotting when Plots is not loaded.
- Tests with and without Plots.
