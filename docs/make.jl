using Documenter
using SBMLToolkitTestSuite

makedocs(
    sitename = "SBMLToolkitTestSuite.jl",
    modules = [SBMLToolkitTestSuite],
    checkdocs = :exports,
    clean = true,
    doctest = true,
    pages = [
        "Home" => "index.md",
        "API Reference" => "api.md",
    ],
)

deploydocs(repo = "github.com/SciML/SBMLToolkitTestSuite.jl.git", push_preview = true)
