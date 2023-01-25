using SBMLToolkitTestSuite
using Test

const case_ids = [1:2...]  # 1822

const logdir = joinpath(@__DIR__, "logs")
ispath(logdir) && rm(logdir, recursive = true)
mkdir(logdir)

df = verify_all(case_ids, logdir)

for i in 1:length(case_ids)
    @test sum(Vector(df[i, ["expected_err", "res"]])) == 1
end
