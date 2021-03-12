using Test
using SymbolicUtils
import IfElse: ifelse

# == / != syntax is nice, let's use it in tests
macro eqtest(expr)
    @assert expr.head == :call && expr.args[1] in [:(==), :(!=)]
    if expr.args[1] == :(==)
        :(@test isequal($(expr.args[2]), $(expr.args[3])))
    else
        :(@test !isequal($(expr.args[2]), $(expr.args[3])))
    end |> esc
end
SymbolicUtils.show_simplified[] = false

include("basics.jl")
include("arrays.jl")
include("order.jl")
include("rewrite.jl")
include("rulesets.jl")
include("code.jl")
include("nf.jl")
include("interface.jl")
include("fuzz.jl")
