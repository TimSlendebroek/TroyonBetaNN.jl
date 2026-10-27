module TroyonBetaNNPlotsExt

# Sample-point plots; loaded with `using Plots`, so FUSE worker processes never load Plots through TroyonBetaNN
using Plots
using Printf
using IMAS
import TroyonBetaNN
for n in names(TroyonBetaNN; all=true, imported=true, usings=true)   # everything visible inside `module TroyonBetaNN`
    if Base.isidentifier(n) && n ∉ (:TroyonBetaNN, :eval, :include) && isdefined(TroyonBetaNN, n) && !isdefined(@__MODULE__, n)
        @eval import TroyonBetaNN: $n
    end
end
import TroyonBetaNN: plot_sample_points

include(joinpath("..", "src", "plot_TBNN.jl"))

end
