module ResultTypes

function result_field(::Type{T}) where {T <: Number}
    isconcretetype(T) || return Number
    o = one(T)
    typeof(o / o - o)
end

function result_field(::Type{T}, ::Type{S}) where {T <: Number, S <: Number}
    RT = result_field(T)
    RS = result_field(S)
    if isconcretetype(RT) && isconcretetype(RS)
        a = one(RT)
        b = one(RS)
        typeof(a / b + a * b - b / a)
    else
        Number
    end
end

function result_field(::Type{T}, ::Type{S}, Ts...) where {T <: Number, S <: Number}
    result_field(result_field(T, S), Ts...)
end

end # module
