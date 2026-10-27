module TroyonBetaNN


using IMAS
using JSON
using Printf
using PrettyTables
using FastInterpolations

import ONNXRunTime as ORT

export Troyon_Data, load_predefined_Troyon_NN_Models

@kwdef mutable struct MLP_Model
    n::Int # toroidal mode number
    W::Matrix{Float64} # map from input to hidden layer
    V::Vector{Float64} # map from hidden layer to output
    βₙ_limit::Float64 = NaN # scalar output
    filePath::String = ""
end

@kwdef mutable struct CNN_Model
    n::Int = 1 # toroidal mode number
    model::ORT.InferenceSession
    input::Dict = Dict()
    βₙ_limit::Float64 = NaN # scalar output
    filePath::String = ""
end

@kwdef mutable struct Sample_Points
    R::Vector{Float64} = []
    Z::Vector{Float64} = []
    ψₙ::Vector{Float64} = [0:0.1:0.9; 0.95; 0.975]
    q::Vector{Float64} = []
    pressure::Vector{Float64} = []
end

@kwdef mutable struct Troyon_Data
    sampPoints::Sample_Points = [] # Sample Points for NN
    MLPs::Vector{MLP_Model} = [] # NN (MLP) models for (n=1,2,3) modes
    CNN::CNN_Model = [] # CNN models for n=1 mode
end


include("calculate_TBNN.jl")
include("print_TBNN.jl")

"""
    plot_sample_points(TD::Troyon_Data, eqt::IMAS.equilibrium__time_slice; fileName_prefix="Troyon_Sample_Points", file_type="png", title_prefix="")

Plots the q/pressure/boundary sample points fed to the Troyon NN and saves the figure.
Needs `using Plots` (implemented in ext/TroyonBetaNNPlotsExt.jl).
"""
function plot_sample_points end

end # module TroyonBetaNN
