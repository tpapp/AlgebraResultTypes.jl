module AlgebraResultTypes

result_field(::T) where T = result_field(Type)
function result_field(::Type{T}) where {T <: Number}
    isconcretetype(T) || return Number
    o = one(T)
    typeof(o / o - o + (o + o))
end

function result_field(::Type{T}, ::Type{S}) where {T <: Number, S <: Number}
    RT = result_field(T)
    RS = result_field(S)
    if isconcretetype(RT) && isconcretetype(RS)
        a = one(RT)
        b = one(RS)
        typeof(a / b + a * b - b / a - a / a + b / b)
    else
        Number
    end
end

"""
    result_field(T1, T2, ...)

Return a supertype of the result type of applying operation `+`, `-`, `*`, `/` on the given
types. Ideally, for concrete types, this is the narrowest concrete type.

You may want to apply `widen` to the result for complex calculations.

Formally, for any values `x1::T1`, `x2::T2`, ..., where  `T1, T2, ... <: Number`, and
operations `op1, op2, ... ∈ (+, -, *, /)`,

```julia
op1(x1, op2(x2, op3(x3, ...))) isa result_field(T1, T2, T3, ...)
```

Any violation of this is a bug, and should be reported as an issue.

The implementation uses heuristics, and may not find the narrowest type, falling back to
`Number` for non-concrete types. Please open an issue if you think this can be improved for
some concrete types.
"""
function result_field(::Type{T}, ::Type{S}, Ts...) where {T <: Number, S <: Number}
    result_field(result_field(T, S), Ts...)
end

function result_ring(::Type{T}) where {T <: Number}
    isconcretetype(T) || return Number
    o = one(T)
    typeof(o * o - o + (o + o))
end

function result_ring(::Type{T}, ::Type{S}) where {T <: Number, S <: Number}
    RT = result_ring(T)
    RS = result_ring(S)
    if isconcretetype(RT) && isconcretetype(RS)
        a = one(RT)
        b = one(RS)
        typeof(a * b + b * a - a + b)
    else
        Number
    end
end

"""
    result_ring(T1, T2, ...)

Return a supertype of the result type of applying operation `+`, `-`, `*`, on the given
types. Ideally, for concrete types, this is the narrowest concrete type.

You may want to apply `widen` to the result for complex calculations.

See [`result_field`](@ref) for details, *mutatis mutandis*.
"""
function result_ring(::Type{T}, ::Type{S}, Ts...) where {T <: Number, S <: Number}
    result_ring(result_ring(T, S), Ts...)
end

function result_group(op,::Type{T}) where {T <: Number}
    o = one(T)
    typeof(op(o,inv(o)))
end

function result_group(op,::Type{T}, ::Type{S}) where {T <: Number, S <: Number}
    RT = result_group(op,T)
    RS = result_group(op,S)
    a = one(RT)
    b = one(RS)
    typeof(op(op(a,b),inv(a)))
end

"""
    result_group(op,T1, T2, ...)

Return a supertype of the result type of applying group operation `op`, on the given
types. Ideally, for concrete types, this is the narrowest concrete type.

```Julia
julia> result_group(+,Int,Rational{Int})
Float64
```

You may want to apply `widen` to the result for complex calculations.

See [`result_field`](@ref) for details, *mutatis mutandis*.
"""
function result_group(op,::Type{T}, ::Type{S}, Ts...) where {T <: Number, S <: Number}
    result_group(result_group(op,T, S), Ts...)
end

end # module
