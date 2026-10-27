module TroyonBetaNNPlotsExt

# Sample-point plots; loaded with `using Plots`, so FUSE worker processes never load Plots through TroyonBetaNN
using Plots
using Printf
using IMAS
import TroyonBetaNN
# mirror the TroyonBetaNN namespace (what the included code saw inside `module TroyonBetaNN`): its own and imported names first,
# then the modules it brings in with `using` (names(...; usings=true) would need Julia 1.12)
for n in names(TroyonBetaNN; all=true, imported=true)
    if Base.isidentifier(n) && n ∉ (:TroyonBetaNN, :eval, :include) && isdefined(TroyonBetaNN, n) && !isdefined(@__MODULE__, n)
        @eval import TroyonBetaNN: $n
    end
end
using FastInterpolations, IMAS, JSON, PrettyTables, Printf
import TroyonBetaNN: plot_sample_points

include(joinpath("..", "src", "plot_TBNN.jl"))

end
