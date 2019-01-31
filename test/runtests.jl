using ResultTypes: result_field
using Test
import ForwardDiff

function test_calc(a)
    abs2(a + a + one(a))/(-a)
end

function test_calc(a, b)
    abs2(a + a + one(a))/(-a) + (a/b - b/a + a/a + b/b)
end

@testset "result_field" begin
    test_types = (# Base
                  Float64, Int, Rational{Int}, Complex{Float64}, Rational{Int16}, Int8,
                  Float32,
                  # packages
                  ForwardDiff.Dual{:foo,Float64,3})

    @test result_field(Real) ≡ Number
    for T in test_types
        @test typeof(test_calc(one(T))) ≡ result_field(T)
        @test result_field(T, Real) ≡ Number
        for S in test_types
            @test typeof(test_calc(one(T), one(S))) ≡ result_field(T, S)
            @test result_field(T, S, Real) ≡ Number
            for Z in test_types
                @test typeof(test_calc(one(T), test_calc(one(S), one(Z)))) ≡ result_field(T, S, Z)
            end
        end
    end
end
