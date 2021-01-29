using Distributed

procs = addprocs()

@everywhere include("src/SymbolicRegression.jl")
@everywhere using .SymbolicRegression

X = randn(Float32, 5, 100)
y = 2 * cos.(X[4, :]) + X[1, :] .^ 2 .- 2

options = SymbolicRegression.Options(
    binary_operators=(+, *, /, -),
    unary_operators=(cos, exp),
    npopulations=20,
)
niterations = 5

hallOfFame = EquationSearch(X, y, niterations=niterations, options=options)

rmprocs(procs)
