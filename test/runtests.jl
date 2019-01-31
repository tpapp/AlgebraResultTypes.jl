using ResultTypes: result_field
using Test
import ForwardDiff, ReverseDiff

function test_calc(a)
    (a + a + one(a))^2/(-a)
end

function test_calc(a, b)
    (a + a + one(a))^2/(-a) + (a/b - b/a)
end

@testset "field" begin
    test_types = (Float64, Int, ForwardDiff.Dual{:foo,Float64,3})

    @test result_field(Real) ≡ Number
    for T in test_types
        @test typeof(test_calc(one(T))) ≡ result_field(T)
        @test result_field(T, Real) ≡ Number
        for S in test_types
            @test typeof(test_calc(one(T), one(S))) ≡ result_field(T, S)
        end
    end
end
