using Test

import TroyonBetaNN as TBNN
using IMAS

include("references.jl")

file_path = joinpath(pkgdir(TBNN), "test", "data", "dd_D3D.json")
dd = IMAS.json2imas(file_path)

@testset "TroyonBetaNN.jl" begin
    # run & show simple terminal output
    TD_vec = TBNN.calculate_Troyon_beta_limits_for_IMAS_dd(dd)

    TD = TD_vec[2]
    @testset "Check MLP's βₙ_limits with references" begin
        @test isapprox(TD.MLPs[1].βₙ_limit, 3.5040075164972104; rtol=1e-3)
        @test isapprox(TD.MLPs[2].βₙ_limit, 3.5221171764974266; rtol=1e-3)
        @test isapprox(TD.MLPs[3].βₙ_limit, 3.9239197016232703; rtol=1e-3)
    end

    @testset "Interpolation outputs (sample points)" begin
        @test isapprox(TD.sampPoints.q,        Q_REF;        rtol=1e-3)
        @test isapprox(TD.sampPoints.pressure, PRESSURE_REF; rtol=1e-3)
        @test isapprox(TD.sampPoints.R,        R_REF;        rtol=1e-3)
        @test isapprox(TD.sampPoints.Z,        Z_REF;        rtol=1e-3)
    end
end

# Plots is a weak dependency (ext/TroyonBetaNNPlotsExt.jl): verbose=true only plots once Plots is loaded
@testset "verbose without Plots" begin
    @test Base.get_extension(TBNN, :TroyonBetaNNPlotsExt) === nothing
    dir = mktempdir()
    @test_logs (:warn, r"using Plots") match_mode = :any cd(() -> TBNN.calculate_Troyon_beta_limits_for_IMAS_dd(dd; verbose=true), dir)
    @test isempty(readdir(dir))
end

ENV["GKSwstype"] = "nul" # headless GR
using Plots

@testset "verbose with Plots saves sample-point plots" begin
    @test Base.get_extension(TBNN, :TroyonBetaNNPlotsExt) !== nothing
    dir = mktempdir()
    cd(() -> TBNN.calculate_Troyon_beta_limits_for_IMAS_dd(dd; verbose=true), dir)
    @test any(startswith("Troyon_Sample_Points"), readdir(dir))
end
