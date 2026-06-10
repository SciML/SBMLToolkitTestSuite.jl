using SafeTestsets, Test

const GROUP = get(ENV, "GROUP", "All")

if GROUP == "All" || GROUP == "Core"
    @safetestset "SBML Test Suite" begin
        include("sbmltestsuite.jl")
    end
end

if GROUP == "QA"
    using Pkg
    Pkg.activate(joinpath(@__DIR__, "qa"))
    Pkg.develop(path = joinpath(@__DIR__, ".."))
    Pkg.instantiate()
    include(joinpath(@__DIR__, "qa", "qa.jl"))
elseif GROUP == "All"
    @safetestset "JET static analysis" begin
        include(joinpath("qa", "qa.jl"))
    end
end
