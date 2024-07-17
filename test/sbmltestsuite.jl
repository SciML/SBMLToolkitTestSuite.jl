using SBMLToolkitTestSuite
using Test
using JSON

const case_ids = [1:1822...]

const logdir = joinpath(@__DIR__, "logs")
ispath(logdir) && rm(logdir, recursive = true)
mkdir(logdir)

# Load previous results if they exist
prev_results_file = joinpath(logdir, "previous_results.json")
prev_results = isfile(prev_results_file) ? Dict(JSON.parsefile(prev_results_file)) : Dict()

# Run the test suite
df = verify_all(case_ids, logdir)

# Save current results
current_results = Dict()
for i in 1:length(case_ids)
    current_results[string(case_ids[i])] = df[i, "res"]
end
open(joinpath(logdir, "current_results.json"), "w") do io
    JSON.print(io, current_results)
end

# Compare current results with previous results and log the results
for (case_id, result) in current_results
    if haskey(prev_results, case_id)
        @test result == prev_results[case_id]
    end
end

# Log the results
n_download_errors = sum(startswith.("Downloads.RequestError", df[:, "err"]))
total_cases = length(case_ids) - n_download_errors
passed_cases = sum(df[i, "res"])
open(joinpath(logdir, "test_summary.log"), "w") do io
    println(io, "Total cases: $total_cases")
    println(io, "Passed cases: $passed_cases")
    println(io, "Failed cases: $(total_cases - passed_cases)")
end
