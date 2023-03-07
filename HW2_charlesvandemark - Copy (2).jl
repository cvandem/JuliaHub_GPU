### A Pluto.jl notebook ###
# v0.19.22

using Markdown
using InteractiveUtils

# ╔═╡ 1cc606d4-4788-426a-88bc-3d0c387bfb78
using LinearAlgebra, BenchmarkTools, SparseArrays, PlutoTeachingTools

# ╔═╡ 7679b2c5-a644-4341-a7cc-d1335727aacd
# edit the code below to set your name and kerberos ID (i.e. email without @mit.edu)

student = (name = "Charles Van De Mark", kerberos_id = "cvandem")


# ╔═╡ e5a1396f-03da-442d-a968-259effe56c84
#begin
#	a, b, c, d, e, f = time_matmul(50), time_matmul(100), time_matmul(200), #time_matmul(400), time_matmul(800), time_matmul(1600)
#end

# ╔═╡ bf6c498d-9e9b-421a-891f-520c7832b70e
#g = time_matmul(3200)

# ╔═╡ 6a9940e0-575f-4aae-a615-3e3fcef8866e
#h = time_matmul(6400)

# ╔═╡ 0d0dd5fd-11cf-43a7-aa91-90608a2a3249
#i = time_matmul(12800)

# ╔═╡ 64e7f4c8-1f4b-4e57-aed0-c9d373897c47
1:5 # I'm a range

# ╔═╡ 981a4406-8d82-448c-8bbc-753a0409ad29
[1:5;]

# ╔═╡ 0cb96697-14be-432e-9ee6-87298f560c6b
[ 1:5, 6:10] # I'm a vector of ranges, which  may not be useful

# ╔═╡ 4feedad0-3dd5-435d-b980-9b5dbabff0bf
vcat( [18,3],[3],[7]) # vertical concatanation

# ╔═╡ bf23421c-5224-4dc7-93e9-092e77734918
ones(Int,5) # i'm ones

# ╔═╡ a6a48234-ea12-499f-b4e9-6c5c6550ad08
fill(1,5) # I'm also ones

# ╔═╡ 7da4e5a4-a8a1-451e-a38e-f38b33aadb93
begin
	rows = vcat( [1:20;] , [2:20;] , fill(1,19) )
	cols = vcat( [1:20;] , fill(1,19), [2:20;] )
	#vals = rand(1,20)
	valsd = [1, 8, 3, 6, 9, 12, 43, 61, 7, 8, 91, 45, 2, 90, 12, 14, 15, 81, 71, 66]
	valsh = [5, 7, 19, 3, 6, 20, 87, 34, 56, 10, 39, 71, 22, 4, 8, 59, 31, 99, 38]
	valsv = [5, 7, 19, 3, 6, 20, 87, 34, 56, 10, 39, 71, 22, 4, 8, 59, 31, 99, 38]
	fillout = vcat(valsd, valsh, valsv)
	sparse_matrix = sparse(rows, cols, fillout)
end
	

# ╔═╡ 0ca2494e-0eca-4d4a-8726-080c95c868a5
struct newtype
	f :: Float64
	v :: Vector{Int}
end

# ╔═╡ b224fbc0-d2f9-4519-bcc6-ee2678fd5fe7
begin
	q=newtype( rand(), rand(1:10,4))
	#qget = length(q)
	#q1 = q.f
end

# ╔═╡ d8d4c0f2-3042-4ce1-9345-f95143beba8d
struct SymArrowFloat
	v1 :: Vector{Float64} #long - 1
	v2 :: Vector{Float64} #long
end

# ╔═╡ 8cf6f68b-1dfe-4e1e-9c62-8e064a227bb5
#using Base.show

# ╔═╡ 9dc966c9-26be-45c6-ad70-9301d834b992
# complete the line below
begin
	Matrix(M::SymArrowFloat) = collect(sparse(vcat([1:length(M.v2);], [2:length(M.v2);], fill(1,length(M.v1))),vcat([1:length(M.v2);], fill(1,length(M.v1)), [2:length(M.v2);]),vcat(M.v2, M.v1, M.v1)))
	
end

# ╔═╡ f5012c40-2f20-47a9-b7dd-5cc157bf4697
# modify the line below
Base.:+(s::SymArrowFloat,t::SymArrowFloat) = SymArrowFloat(s.v1+t.v1, s.v2+t.v2)

# ╔═╡ fac3d6c9-59a3-4d8a-8f6c-e349b80985a8
#testcode
begin
	vec1 = [100, 2, 3, 4, 5]
	#vec2 = vec1[2:1:length(vec1)]
	#vec2 = vec1[1,[2]]
	#vec2 = reverse(vec1[2:1:length(vec1)])
	#vec2 = vec1[1]
end

# ╔═╡ 4c344a55-92e8-4577-81ae-87210c3cd1c0
struct SymArrow{T}
    diag::Vector{T}
    first_row::Vector{T}  # without first entry
end

# ╔═╡ 5296c835-0bf8-470f-bcf3-055ae6093865


# ╔═╡ e1fa10a5-05bf-46f5-b53e-055dd39481e1
begin
	Matrix(M::SymArrow) = collect(sparse(vcat([1:length(M.diag);], [2:length(M.diag);], fill(1,length(M.first_row))),vcat([1:length(M.diag);], fill(1,length(M.first_row)), [2:length(M.diag);]),vcat(M.diag, M.first_row, M.first_row)))
end

# ╔═╡ 8f266bf4-8e8e-47ed-8f06-2be30bac3287
# modify the line below
#Base.show(io::IO, A::SymArrowFloat) = display(Matrtix(A)) # change the argument and the rhs

Base.show(A::SymArrowFloat) = display(Matrix(A))

# ╔═╡ bcd4e147-b1bc-4de5-8057-e377af06e96a
Base.:+(s::SymArrow,t::SymArrow) = SymArrow(s.first_row+t.first_row, s.diag+t.diag)

# ╔═╡ 69786b36-9ba4-4dc9-825b-43437bd69197
# Modify the line below

Base.:*(s::SymArrowFloat,t::Vector{Float64}) = ((s.v2.*t) .+ vcat(sum(s.v1 .* t[2:1:length(t)]), s.v1 .* t[1]))

# ╔═╡ 7bc4841a-d88f-4e8d-9bdd-08fc288590a2
begin
	testadd1 = SymArrowFloat([1, 2, 3, 4], [7, 8, 9, 10, 11])
	testadd2 = SymArrowFloat([2, 3, 4, 5], [10, 11, 12, 13, 14])
	sumtestadd = Base.:+(testadd1, testadd2)
	Base.show(sumtestadd)
end

# ╔═╡ a0912bed-6046-4bb2-86ce-a9226eede60e
Base.:*(s::SymArrow,t::Vector) = ((s.diag.*t) .+ vcat(sum(s.first_row .* t[2:1:length(t)]), s.first_row .* t[1]))

# ╔═╡ a9b81d9b-9243-428d-87e5-77db83afb00b
function time_matmul(n)
	A = rand(n,n)
	B = rand(n,n)	
	(2n^3)/ @belapsed $A*$B  # operations divided by time in seconds
end

# ╔═╡ 3a337512-d321-4d9a-9c24-9879a971e8c5
a = time_matmul(50)

# ╔═╡ a5a9816f-61bc-424b-b0fc-237fe2d8b501
b = time_matmul(100)

# ╔═╡ e356dd4b-1358-44cc-a9ae-027006e5f676
c = time_matmul(200)

# ╔═╡ 4f950e94-21e4-4b4e-8536-db6108c1efbe
d = time_matmul(400)

# ╔═╡ c3f40e51-2471-409d-8f7f-10be9c219e9c
e = time_matmul(800)

# ╔═╡ 230b7f2e-c0ec-4bd0-a7f0-1cd5e558ecb9
f = time_matmul(1600)

# ╔═╡ 57d835e2-1d5b-4f79-a417-24e0af5667d3
function time_matmul_LtoR(n)
	v = rand(n,1)
	A = rand(n,n)
	B = rand(n,n)	
	C = rand(n,n)
	D = rand(n,n)
	(2n^3)/ @belapsed ((($A*$B)*$C)*$D)*$v  # operations divided by time in seconds
end

# ╔═╡ f2865e72-6eb2-456f-b9cb-de3f46226164
function time_matmul_RtoL(n)
	v = rand(n,1)
	A = rand(n,n)
	B = rand(n,n)	
	C = rand(n,n)
	D = rand(n,n)
	(2n^3)/ @belapsed $A*($B*($C*($D*$v)))  # operations divided by time in seconds
end

# ╔═╡ 1fc99688-5a84-4574-889c-fd01c3760a02
a1,a2 = time_matmul_LtoR(50),time_matmul_RtoL(50)

# ╔═╡ 7af1ae46-8c11-4455-8efd-be01d8c0d9ff
b1,b2 = time_matmul_LtoR(100),time_matmul_RtoL(100)

# ╔═╡ a21a882b-5c2a-4051-a592-d7167b03c3bf
c1,c2 = time_matmul_LtoR(200),time_matmul_RtoL(200)

# ╔═╡ 44af59d3-07b5-44a6-8431-2a950f8d9d63
d1,d2 = time_matmul_LtoR(400),time_matmul_RtoL(400)

# ╔═╡ 382c4fc5-6ce0-4a95-8dde-75c4d733b27f
e1,e2 = time_matmul_LtoR(800),time_matmul_RtoL(800)

# ╔═╡ 2504c3c8-6fa0-4c68-9755-f8d892630224
f1,f2 = time_matmul_LtoR(1600),time_matmul_RtoL(1600)

# ╔═╡ b58891b0-890b-47e7-b304-49c8f5fefc90
begin
	testmult1 = SymArrowFloat([1, 2, 3, 4], [3, 6, 9, 12, 15])
	testmult2 = [2., 3., 10., 5., 4.]
	multestadd = Base.:*(testmult1, testmult2)
	Base.show(multestadd)
end

# ╔═╡ 1c10c54b-2fa1-45fc-8f82-46173c26c8bb
begin
	testadd1_T = SymArrow([1, 2, 3, 4], [7, 8, 9, 10, 11])
	testadd2_T = SymArrow([2, 3, 4, 5], [10, 11, 12, 13, 14])
	sumtestadd_T = Base.:+(testadd2_T, testadd1_T)
	#Base.show(sumtestadd_T)
end

# ╔═╡ 5a5f54ae-6e9d-48fb-93dc-1108fb2d9abc
begin
	testmult1_T = SymArrow([3, 6, 9, 12, 15], [1, 2, 3, 4])
	testmult2_T = [2., 3., 10., 5., 4.]
	multestadd_T = Base.:*(testmult1_T, testmult2_T)
	#Base.show(multestadd_T)
end

# ╔═╡ fcf046f5-4d83-4869-a156-4dbcd113e694
struct SymArrow2{T} <: AbstractMatrix{T}
    diag::Vector{T}
    first_row::Vector{T}  
end

# ╔═╡ 72a52868-855d-402e-b133-4898270faa77
testmult1_TX = SymArrow2([3, 6, 9, 12, 15], [1, 2, 3, 4])


# ╔═╡ 5af359e0-791d-49bf-b655-0a45db48c00f
begin
	import Base: size, getindex
	
	size(A::SymArrow2{T}) where T = (length(A.diag), length(A.diag)) 
	
	function getindex(A::SymArrow2{T}, i, j) where T
	    
	    if i == j  return A.diag[i] end 
	    if i == 1  return A.first_row[i] end
	    if j == 1  return A.first_row[j] end
	
	    return zero(T)  # otherwise return zero of type T
	end
end

# ╔═╡ 9c384715-5bf5-4308-94ef-db4f26be45a4
md"_Homework 2, version 1.3 -- 18.337 -- Spring  2023_"

# ╔═╡ f8750fa4-8d49-4880-a53e-f40a653c84ea
md"HW is to be submitted on Canvas in the form of a .jl file and .pdf file (use the browser print)"

# ╔═╡ bec48cfd-ac3b-4dae-973f-cf529b3cdc05
md"""
# Homework 2: Using Julia's type system

HW2 release date: Saturday, Feb 18, 2023.

**HW2 due date: This is short enough to be due, 
Thursday, February 23, 2023, 11:59pm EST**, 
but I will accept it as late as Wednesday March 1, 2023
given the holiday weekend (President's day) and all.
"""

# ╔═╡ bee4cd12-8ba4-4c43-b1d6-3e686f914e44
md"## Exercise 1 - Comparing matrix multiplies

> Task: 1a. If an $m \times n$ matrix is multiplied by and $n \times k$  matrix, how many multiplies and adds are there approximately?
"

# ╔═╡ 3f924a9c-c0f9-41e9-b96b-cc5f5de6cefa
md"
This operation results in a $m \times k$ matrix where each entry is multiplied $n$ times and there are $n$-1 additions for each entry.

=> Multiplies: $(n)(m)(k)$

=> Adds: $(n-1)(m)(k)$
"

# ╔═╡ 008edb66-c860-4d14-ba43-16dedc80e141
md"#
>Task: 1b.  Write a test to compare matrix multiply  **rates** (units: ops/sec) for $n=50,100, 200, 400, 800$ and $1600$ by taking the number of operations and dividing by time. (You may find Pluto is not great for timing experiments, and it's okay to switch to Jupyter , vscode , or whatever you like, just provide your files) You can use the function below or make your own.  What kind of machine do you have, and estimate the asymptotic speed of a matmul on your machine?
"

# ╔═╡ 711dd1dd-1e67-4e0d-9523-59c9ec5d9d61
md"
My machine has an Intel Core i9-12900H processor. As the per operation time seems to remain relatively constant at around 2.25e10 to 2.5e10 ops/sec at larger matrix sizes, the asymptotic speed of this operation is likely ~$O(n^3)$ (or perhaps slightly less).
"

# ╔═╡ 2d2922ec-d0d9-4d53-8103-2a072295e7d5
md" >Task: 1c.  Compare timings for $A*B*C*D*v$ going left to right and right to left (by placing parentheses appropriately) as a function of $n$ , where $A,B,C,D$ are square matrices of size n, and $v$ is a vector of size $n$. 
"

# ╔═╡ 393f7223-9b1c-46fc-8aa5-96517f5739ae
md"
Your code and timing go here
"

# ╔═╡ 318944dd-b5d8-4274-b725-ea2ac17c6bf3
md"
As expected, the right to left computation exhibits greatly increased ops/sec (proportionately higher with larger matrices) as the earlier vector multiplication reduces total operations.
"

# ╔═╡ 0da73ecd-5bda-4098-8f13-354af436d231
md"## Exercise 2 - _Write a simple power method_

>Task: First we will ask you to fill in the blank in a simple power iteration to obtain an approximation to the largest eigenvalue of a matrix. This code will be used in Exercise 3.
"

# ╔═╡ c442576f-b898-4a01-83a6-1d77ecd54836
function power_method(M)
		v = rand(size(M,1))
	    for i in 1:100
	         # your code goes here
			 v = M*v
		end	    
	    return  norm(M*v) / norm(v) 
end

# ╔═╡ cdf2c682-727d-4810-8070-087f910867ea
function time_power(sm)
	@belapsed power_method($sm)  # operations divided by time in seconds
end

# ╔═╡ 22a6b164-271d-44bc-9b91-fe38f2205bf7
time_power(sparse_matrix)

# ╔═╡ bad69026-2dcc-4370-9cb1-c90953398f59
let
	M = rand(1000,1000)
	result = power_method(M)
	if !(result isa Number)
		md"""
!!! warning "Not a number"
    `power_method` did not return a number. Did you forget to write `return`?
		"""
	elseif abs(result - real(eigvals(M)[end])) < 0.01
		md"""
!!! correct
    Well done!
		"""
	else
		md"""
!!! warning "Incorrect"
    Keep working on it!
		"""
	end
end

# ╔═╡ 172bd4bd-5ea9-475f-843d-abb86ffaed34
md"## Exercise 3 - _Symmetric Arrow Matrix_

A symmetric [arrow (or arrowhead)](https://en.wikipedia.org/wiki/Arrowhead_matrix) matrix is a matrix whose elements are non-zero only on the diagonal and in the first row and (symmetrically) the first column:

"

# ╔═╡ 087bf886-0e02-45bc-b2c9-f9fcd6f3c0ee
md">Task:  (3.1) Use Julia's sparse matrix capabilities to define a symmetric arrow matrix from its first row and diagonal: define vectors I and J containing the row (i) and column (j) coordinates of the non-zero entries, and a vector V of the corresponding values. Create the matrix with sparse(I, J, V). [Note: be careful not to define the upper left entry more than once.]
"

# ╔═╡ 27e25ab8-6886-4c8a-b147-e194b2323274
md"
Write your function here that takes vectors r and d in and returns the sym arrow matrix out.  (You can have r and d of length n, but you will only use 
one of r[1] and d[1])

You might play with some of the Julia syntax that follows
"

# ╔═╡ bca4aca6-19d9-40b2-9cdf-c43a4305769a
md"
>Task: Fix a (largeish) arrow matrix that you will use throughout the question, and time how long the power method takes
"

# ╔═╡ 7bb9b046-8a9f-4b64-9740-3dd7da62a4b3
md"
Your code to define the matrix goes here
"

# ╔═╡ 9f675139-2022-4cb2-b546-44d32e13b263
md"
Your timing goes here
"

# ╔═╡ d80f43d8-ecf2-4d06-9d00-5de7811526e7
md"
(3.2)
Let's remember how to make a new Julia \"type\" (a data structure):
"

# ╔═╡ b5cc38d7-996c-464d-b646-791b8e440bb0
md">Task: Implement a new Julia type, SymArrowFloat  that contains two vectors of Float64: (This will only work for vectors of Float64, in 3.3 we will write the generic code)

Inputs:
1. the first row or column; and
2. the diagonal entries.
"


# ╔═╡ 72bf7993-71d6-49a3-b10d-5e6bc056523b
md"
your code here for SymArrowFloat
"

# ╔═╡ 1478aba5-42d9-4f89-8b9e-4745c3f8602f
md"
>Task: Write the following functions acting on this type:
`Matrix`, that creates a standard Julia matrix with the same contents

`+` for adding two arrow matrices

`*` for matrix-vector multiplication of a SymArrowFloat with a vector of Float64s
show to display the matrix in a clear way.



(Import Base.show and then define show(io::IO, A::SymArrowFloat).)

Write tests to make sure that * works 

Find the largest eigenvalue of a symmetric arrow matrix using the power_method code, and check that it is correct using ≈ .
"

# ╔═╡ 10ebbd90-298c-4d2c-8a1b-3cf502f14cd4
md">Task: Find the largest eigenvalue of a symmetric arrow matrix using the power_method code, and check that it is correct using ≈ .
"

# ╔═╡ 287fa3e2-21e4-4f77-ae5a-0c71dc8e5839
let
	result2 = power_method(Matrix(sumtestadd))
	if (result2 ≈ real(eigvals(Matrix(sumtestadd))[end]))
		md"""
!!! correct
    correct eigenval
		"""
	end
end

# ╔═╡ 4559691d-b93c-4d66-984f-0560ad458008
 md"
 (3.3) Now suppose that we need an arrow matrix with elements that are rationals, or complex numbers. We could define separate, new types for each of those possibilities (SymArrowRational, SymArrowComplex, etc.). However, Julia provides an alternative that provides, once more, for generic code:

To make a new type SymArrow that can contain elements of an arbitrary type T, such as rationals or complex numbers, we use the following syntax:
"

# ╔═╡ f42dc4ef-8af1-4c4b-a069-94b4460078cc
md"
Here, T is a type parameter: we are defining a template for a new type that will contain elements of type T.

>Task: Redefine Matrix, + and *. These must also have type parameters, for example the signature of the + method will be

+{T}(A::SymArrow{T}, B::SymArrow{T}) = ⋯
"

# ╔═╡ 4c44d9d4-58d7-4081-8f9d-800a3323b247
md"
(3.4)
 An alternative way to define such a type is to use some of the built-in machinery that Julia provides for arrays. In order to do so, we will make a new SymArrow2 type, which we will declare to be a subtype (<:) of the abstract type AbstractMatrix, as follows:
"

# ╔═╡ a7724b60-0c8a-4f83-bcfa-c5be4ea085eb
md"
For a detailed discussion of parametric types, see the [Julia manual](https://docs.julialang.org/en/v1/manual/types/#Parametric-Types) or the tutorial (video from 2016)[https://www.youtube.com/watch?v=rAxzR7lMGDM] . (type is now struct)
"

# ╔═╡ d75b96c9-7435-4fc7-b905-b036e20851af
md"
This will allow us to use many so-called fall-back methods that Julia provides, defined for types that to automatically obtain functionality, without explicitly providing it ourselves, as we had to in question (ii). However, this may lead to less efficient code, since the generic versions will not take advantage of the structure.
"


# ╔═╡ eb77f415-cd9e-4176-bc9f-b298ffae8fd4
md"
There was no error, likely because I had already constructed my definition, but I had earlier had the error that T was undefined in my functions.  
"

# ╔═╡ e4687b24-add7-4a96-b12e-aef540327c81
md">Task: First, try defining a SymArrow2. What does the error message say? We see that in order to use the Julia-provided functionality, we must first define two methods for objects A of type SymArrow2:
"

# ╔═╡ 62d9f2ad-638e-4444-ba08-7f2d02331e37
md"
size(A), which returns, as a tuple, the size of the array (matrix) in each direction

getindex(A, i, j), which defines what is returned when we query A[i, j], i.e. access to the element at position (i, j)
"

# ╔═╡ d67d3fbb-0f44-4c26-ae80-aa7b6343e6d9
md">Task: This is done as follows; fill in the details for getindex:
	"

# ╔═╡ 7a36f9e1-51cb-44b7-8c54-630d8762fd11
md">Task: Now check that Matrix and * work automatically for this type, having defined only size and getindex.

Time the power method for each version of the type. Which is fastest? Explain the trade-off between generic programming and execution speed.
"

# ╔═╡ eb0b279e-eff2-461d-b598-20cb2207aee2
begin
	testadd1_T2 = SymArrow2([1, 2, 3, 4], [7, 8, 9, 10, 11])
	testadd2_T2 = SymArrow2([2, 3, 4, 5], [10, 11, 12, 13, 14])
	sumtestadd_T2 = Base.:+(testadd2_T2, testadd1_T2)

end

# ╔═╡ 19023874-4f6e-45f2-aa27-8d1850761bbf
begin
	testmult1_T2 = SymArrow2([3, 6, 9, 12, 15], [1, 2, 3, 4])
	testmult2_T2 = [2., 3., 10., 5., 4.]
	multestadd_T2 = Base.:*(testmult1_T2, testmult2_T2)
end

# ╔═╡ 73b3d11a-cae3-48cc-9359-cb5c26920084
md"

SymArrow2 does indeed work automatically, without redefining Matrix, +, or *
"

# ╔═╡ 92dcee24-4345-4da3-8008-8dd61bb5b061
t_1 = time_power(Matrix(sumtestadd_T))
#t_2 = time_power(Matrix(sumtestadd_T2)) #reload Matrix def before running

# ╔═╡ 1b763471-bc90-4de7-906f-1a47f3c6429c
md"

The generic version of the type should be slower consistently (though little difference was seen here); the overhead from managing arbitrary data types may limit the speed, but it allows for more flexibility in coding.
"

# ╔═╡ ebd42c0b-01a6-4257-a05b-f722cc78de99
md" ## Exercise 4 _Hello World on a GPU_

Follow the steps outlined in [this document](https://docs.google.com/document/d/146_lPEcIq6WODdw8oPUVs6Bflp5ptjL6t0YQ6zuyG44/edit?usp=sharing) to log in to JuliaHub and connect to a GPU Pluto notebook.
copy and paste this notebook URL: https://raw.githubusercontent.com/mitmath/JuliaComputation/main/homeworks/hw5-gpu.jl

Run the JuliaHub notebook and answer the following questions **here**.
You do not need to submit the JuliaHub notebook, only this one.
"

# ╔═╡ e21b0308-c86f-4343-8bd5-bfa805f80c25
danger(md"Under no circumstances will you be charged. Do not be afraid of
any costs that appear.
")

# ╔═╡ 8750a1af-cbe8-42de-8ca4-d82542f6c981
md"

I am asking Prof. Edelman for an extension on this part, as I was not able to recieve a log in for juliahub.
"

# ╔═╡ 07bfc3d8-288e-4ace-ad3b-574e7ace4a14
md"""
!!! danger "Task 3.1"
	What speedup did you observe when running matrix multiply on the GPU compared to the CPU? For example if the CPU calculation took 1 second and the GPU computation took 0.5 seconds, you would have a 2x speedup.
"""

# ╔═╡ e633216b-baaf-42a3-8d52-4ceaef6e959a


# ╔═╡ 5bdb8764-cd7c-4300-aa1e-c8f5dc297832
hint(md"
Look at the median time in the output of `@benchmark`.
")

# ╔═╡ f3f7144a-3137-4e5d-8289-35514728cf88
md"""
> Your answer here
"""

# ╔═╡ 76b57b6c-9af6-455a-897b-59dd311e8b01
md"""
!!! danger "Task 3.2"
	What value did you observe for the mean deviation between the matrix elements computed on the CPU vs. GPU?
"""

# ╔═╡ 6efcc417-78ab-4914-b52a-a05da797f2a3
md"""
> Your answer here
"""

# ╔═╡ 20ed1521-fb1d-43cd-8c6f-15041fc512ec
if student.kerberos_id === "ptcorgi"
	md"""
!!! danger "Oops!"
    **Before you submit**, remember to fill in your name and kerberos ID at the top of this notebook!
	"""
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[compat]
BenchmarkTools = "~1.3.2"
PlutoTeachingTools = "~0.2.5"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.5"
manifest_format = "2.0"
project_hash = "60edc7421f93de178f52ff63f0c3a390c9687e19"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "d9a9701b899b30332bbcb3e1679c41cce81fb0e8"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.3.2"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "0e5c14c3bb8a61b3d53b2c0620570c332c8d0663"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "1.2.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.1+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "b289a36229c94e326282f36b3e24416a08dc7bd9"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.9.21"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "2422f47b34d4b127720a18f86fa7b1aa2e141f29"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.18"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoweredCodeUtils]]
deps = ["JuliaInterpreter"]
git-tree-sha1 = "60168780555f3e663c536500aa790b6368adc02a"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "2.3.0"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "42324d08725e200c23d4dfb549e0d5d89dede2d2"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.10"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.Parsers]]
deps = ["Dates", "SnoopPrecompile"]
git-tree-sha1 = "6f4fbcd1ad45905a5dee3f4256fabb49aa2110c6"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.7"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.PlutoHooks]]
deps = ["InteractiveUtils", "Markdown", "UUIDs"]
git-tree-sha1 = "072cdf20c9b0507fdd977d7d246d90030609674b"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0774"
version = "0.0.5"

[[deps.PlutoLinks]]
deps = ["FileWatching", "InteractiveUtils", "Markdown", "PlutoHooks", "Revise", "UUIDs"]
git-tree-sha1 = "8f5fa7056e6dcfb23ac5211de38e6c03f6367794"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0420"
version = "0.1.6"

[[deps.PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "LaTeXStrings", "Latexify", "Markdown", "PlutoLinks", "PlutoUI", "Random"]
git-tree-sha1 = "ea3e4ac2e49e3438815f8946fa7673b658e35bdb"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.2.5"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "5bb5129fdd62a2bbbe17c2756932259acf467386"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.50"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Revise]]
deps = ["CodeTracking", "Distributed", "FileWatching", "JuliaInterpreter", "LibGit2", "LoweredCodeUtils", "OrderedCollections", "Pkg", "REPL", "Requires", "UUIDs", "Unicode"]
git-tree-sha1 = "90cb983381a9dc7d3dff5fb2d1ee52cd59877412"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.5.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SnoopPrecompile]]
deps = ["Preferences"]
git-tree-sha1 = "e760a70afdcd461cf01a575947738d359234665c"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

[[deps.URIs]]
git-tree-sha1 = "074f993b0ca030848b897beff716d93aca60f06a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.2"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"
"""

# ╔═╡ Cell order:
# ╠═1cc606d4-4788-426a-88bc-3d0c387bfb78
# ╟─9c384715-5bf5-4308-94ef-db4f26be45a4
# ╠═7679b2c5-a644-4341-a7cc-d1335727aacd
# ╟─f8750fa4-8d49-4880-a53e-f40a653c84ea
# ╟─bec48cfd-ac3b-4dae-973f-cf529b3cdc05
# ╟─bee4cd12-8ba4-4c43-b1d6-3e686f914e44
# ╟─3f924a9c-c0f9-41e9-b96b-cc5f5de6cefa
# ╟─008edb66-c860-4d14-ba43-16dedc80e141
# ╠═a9b81d9b-9243-428d-87e5-77db83afb00b
# ╠═e5a1396f-03da-442d-a968-259effe56c84
# ╠═3a337512-d321-4d9a-9c24-9879a971e8c5
# ╠═a5a9816f-61bc-424b-b0fc-237fe2d8b501
# ╠═e356dd4b-1358-44cc-a9ae-027006e5f676
# ╠═4f950e94-21e4-4b4e-8536-db6108c1efbe
# ╠═c3f40e51-2471-409d-8f7f-10be9c219e9c
# ╠═230b7f2e-c0ec-4bd0-a7f0-1cd5e558ecb9
# ╠═bf6c498d-9e9b-421a-891f-520c7832b70e
# ╠═6a9940e0-575f-4aae-a615-3e3fcef8866e
# ╠═0d0dd5fd-11cf-43a7-aa91-90608a2a3249
# ╟─711dd1dd-1e67-4e0d-9523-59c9ec5d9d61
# ╟─2d2922ec-d0d9-4d53-8103-2a072295e7d5
# ╟─393f7223-9b1c-46fc-8aa5-96517f5739ae
# ╠═57d835e2-1d5b-4f79-a417-24e0af5667d3
# ╠═f2865e72-6eb2-456f-b9cb-de3f46226164
# ╠═1fc99688-5a84-4574-889c-fd01c3760a02
# ╠═7af1ae46-8c11-4455-8efd-be01d8c0d9ff
# ╠═a21a882b-5c2a-4051-a592-d7167b03c3bf
# ╠═44af59d3-07b5-44a6-8431-2a950f8d9d63
# ╠═382c4fc5-6ce0-4a95-8dde-75c4d733b27f
# ╠═2504c3c8-6fa0-4c68-9755-f8d892630224
# ╟─318944dd-b5d8-4274-b725-ea2ac17c6bf3
# ╟─0da73ecd-5bda-4098-8f13-354af436d231
# ╠═c442576f-b898-4a01-83a6-1d77ecd54836
# ╟─bad69026-2dcc-4370-9cb1-c90953398f59
# ╟─172bd4bd-5ea9-475f-843d-abb86ffaed34
# ╟─087bf886-0e02-45bc-b2c9-f9fcd6f3c0ee
# ╟─27e25ab8-6886-4c8a-b147-e194b2323274
# ╠═64e7f4c8-1f4b-4e57-aed0-c9d373897c47
# ╠═981a4406-8d82-448c-8bbc-753a0409ad29
# ╠═0cb96697-14be-432e-9ee6-87298f560c6b
# ╠═4feedad0-3dd5-435d-b980-9b5dbabff0bf
# ╠═bf23421c-5224-4dc7-93e9-092e77734918
# ╠═a6a48234-ea12-499f-b4e9-6c5c6550ad08
# ╟─bca4aca6-19d9-40b2-9cdf-c43a4305769a
# ╠═7bb9b046-8a9f-4b64-9740-3dd7da62a4b3
# ╠═7da4e5a4-a8a1-451e-a38e-f38b33aadb93
# ╟─9f675139-2022-4cb2-b546-44d32e13b263
# ╠═cdf2c682-727d-4810-8070-087f910867ea
# ╠═22a6b164-271d-44bc-9b91-fe38f2205bf7
# ╟─d80f43d8-ecf2-4d06-9d00-5de7811526e7
# ╠═0ca2494e-0eca-4d4a-8726-080c95c868a5
# ╠═b224fbc0-d2f9-4519-bcc6-ee2678fd5fe7
# ╟─b5cc38d7-996c-464d-b646-791b8e440bb0
# ╟─72bf7993-71d6-49a3-b10d-5e6bc056523b
# ╠═d8d4c0f2-3042-4ce1-9345-f95143beba8d
# ╠═1478aba5-42d9-4f89-8b9e-4745c3f8602f
# ╠═8cf6f68b-1dfe-4e1e-9c62-8e064a227bb5
# ╠═9dc966c9-26be-45c6-ad70-9301d834b992
# ╠═f5012c40-2f20-47a9-b7dd-5cc157bf4697
# ╠═69786b36-9ba4-4dc9-825b-43437bd69197
# ╠═8f266bf4-8e8e-47ed-8f06-2be30bac3287
# ╠═7bc4841a-d88f-4e8d-9bdd-08fc288590a2
# ╠═b58891b0-890b-47e7-b304-49c8f5fefc90
# ╠═fac3d6c9-59a3-4d8a-8f6c-e349b80985a8
# ╠═10ebbd90-298c-4d2c-8a1b-3cf502f14cd4
# ╠═287fa3e2-21e4-4f77-ae5a-0c71dc8e5839
# ╟─4559691d-b93c-4d66-984f-0560ad458008
# ╠═4c344a55-92e8-4577-81ae-87210c3cd1c0
# ╠═f42dc4ef-8af1-4c4b-a069-94b4460078cc
# ╠═5296c835-0bf8-470f-bcf3-055ae6093865
# ╠═e1fa10a5-05bf-46f5-b53e-055dd39481e1
# ╠═bcd4e147-b1bc-4de5-8057-e377af06e96a
# ╠═a0912bed-6046-4bb2-86ce-a9226eede60e
# ╠═1c10c54b-2fa1-45fc-8f82-46173c26c8bb
# ╠═5a5f54ae-6e9d-48fb-93dc-1108fb2d9abc
# ╟─4c44d9d4-58d7-4081-8f9d-800a3323b247
# ╠═fcf046f5-4d83-4869-a156-4dbcd113e694
# ╟─a7724b60-0c8a-4f83-bcfa-c5be4ea085eb
# ╟─d75b96c9-7435-4fc7-b905-b036e20851af
# ╠═72a52868-855d-402e-b133-4898270faa77
# ╟─eb77f415-cd9e-4176-bc9f-b298ffae8fd4
# ╟─e4687b24-add7-4a96-b12e-aef540327c81
# ╟─62d9f2ad-638e-4444-ba08-7f2d02331e37
# ╟─d67d3fbb-0f44-4c26-ae80-aa7b6343e6d9
# ╠═5af359e0-791d-49bf-b655-0a45db48c00f
# ╟─7a36f9e1-51cb-44b7-8c54-630d8762fd11
# ╠═eb0b279e-eff2-461d-b598-20cb2207aee2
# ╠═19023874-4f6e-45f2-aa27-8d1850761bbf
# ╟─73b3d11a-cae3-48cc-9359-cb5c26920084
# ╠═92dcee24-4345-4da3-8008-8dd61bb5b061
# ╟─1b763471-bc90-4de7-906f-1a47f3c6429c
# ╟─ebd42c0b-01a6-4257-a05b-f722cc78de99
# ╟─e21b0308-c86f-4343-8bd5-bfa805f80c25
# ╠═8750a1af-cbe8-42de-8ca4-d82542f6c981
# ╟─07bfc3d8-288e-4ace-ad3b-574e7ace4a14
# ╠═e633216b-baaf-42a3-8d52-4ceaef6e959a
# ╟─5bdb8764-cd7c-4300-aa1e-c8f5dc297832
# ╟─f3f7144a-3137-4e5d-8289-35514728cf88
# ╟─76b57b6c-9af6-455a-897b-59dd311e8b01
# ╟─6efcc417-78ab-4914-b52a-a05da797f2a3
# ╟─20ed1521-fb1d-43cd-8c6f-15041fc512ec
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
