using SafeTestsets, Test

@safetestset "JET static analysis" begin
    include("jet_tests.jl")
end

@safetestset "SBML Test Suite" begin
    include("sbmltestsuite.jl")
end
