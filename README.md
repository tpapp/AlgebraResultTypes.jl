# AlgebraResultTypes.jl

![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)
[![build](https://github.com/tpapp/AlgebraResultTypes.jl/workflows/CI/badge.svg)](https://github.com/tpapp/AlgebraResultTypes.jl/actions?query=workflow%3ACI)
[![codecov.io](http://codecov.io/github/tpapp/AlgebraResultTypes.jl/coverage.svg?branch=master)](http://codecov.io/github/tpapp/AlgebraResultTypes.jl?branch=master)

A Julia package for calculating result types of arithmetic operations.

## Motivation

A lot of Julia code contains some simple functions to calculate the result types of arithmetic operations. This package aims to be a well-tested centralized implementation of these.

The package is really lightweight and has no dependencies.

## Usage

```julia
julia> using AlgebraResultTypes: result_field, result_ring # no exported symbols
julia> result_field(Float64, Int)
Float64
julia> result_field(Int, Int)
Float64
julia> result_ring(Int, Int)
Int
julia> result_field(Real)
Number # non-concrete fallback
```

## How can you help

Add tests for other types, especially if defined in another package.

If the tests pass, please make a PR.

If they don't, please open an issue, or (ideally) make a PR that includes fixes.
