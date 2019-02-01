using ResultTypes: result_field, result_ring
using Test
import ForwardDiff

TEST_TYPES = (# Base
              Float64, Int, Rational{Int}, Complex{Float64}, Rational{Int16}, Int8,
              Float32,
              # packages -- ADD TESTS HERE
              ForwardDiff.Dual{:foo,Float64,3})

function test_field(a)
    abs2(a + a + one(a))/(-a)
end

function test_field(a, b)
    abs2(a + a + one(a))/(-a) + (a/b - b/a + a/a + b/b)
end

function test_ring(a)
    abs2(a + a + one(a))*(-a)
end

function test_ring(a, b)
    abs2(a + a + one(a))*(-a) + (a*b - b*a + a - b)
end

@testset "result_field deterministic tests" begin
    @test result_field(Real) ≡ Number
    for T in TEST_TYPES
        @test typeof(test_field(one(T))) ≡ result_field(T)
        @test result_field(T, Real) ≡ Number
        for S in TEST_TYPES
            @test typeof(test_field(one(T), one(S))) ≡ result_field(T, S)
            @test result_field(T, S, Real) ≡ Number
            for Z in TEST_TYPES
                @test typeof(test_field(one(T), test_field(one(S), one(Z)))) ≡ result_field(T, S, Z)
            end
        end
    end
end

@testset "result_ring deterministic tests" begin
    @test result_ring(Real) ≡ Number
    for T in TEST_TYPES
        @test typeof(test_ring(one(T))) ≡ result_ring(T)
        @test result_ring(T, Real) ≡ Number
        for S in TEST_TYPES
            @test typeof(test_ring(one(T), one(S))) ≡ result_ring(T, S)
            @test result_ring(T, S, Real) ≡ Number
            for Z in TEST_TYPES
                @test typeof(test_ring(one(T), test_ring(one(S), one(Z)))) ≡ result_ring(T, S, Z)
            end
        end
    end
end
