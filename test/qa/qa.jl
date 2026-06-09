using SBMLToolkitTestSuite
using Test
using JET

@testset "JET static analysis" begin
    # Test getcases - should be fully type stable
    @testset "getcases type stability" begin
        rep = JET.@report_opt target_modules = (SBMLToolkitTestSuite,) SBMLToolkitTestSuite.getcases([1, 2, 3])
        @test isempty(JET.get_reports(rep))
    end

    # Test setup_settings_txt - verify it returns typed Dict
    @testset "setup_settings_txt return type" begin
        settings = SBMLToolkitTestSuite.setup_settings_txt("start: 0\nduration: 10\nsteps: 50")
        @test settings isa Dict{String, Union{Int, Float64}}
        @test settings["start"] isa Union{Int, Float64}
        @test settings["duration"] isa Union{Int, Float64}
        @test settings["steps"] isa Union{Int, Float64}
    end

    # Test that package loads without JET errors
    @testset "Package analysis" begin
        rep = JET.report_package(SBMLToolkitTestSuite; target_modules = (SBMLToolkitTestSuite,))
        @test isempty(JET.get_reports(rep))
    end
end
