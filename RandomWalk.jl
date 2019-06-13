
#Library containing rand() function
using Distributions

#example functions to optimize 
#One Dimension
#(x^2 + x) (x0 = -1)
#(x^3 + 6 * x^2 - 7) (x0 = -1)
#(x^3 +6x^2 + 9x - 3) (x0 = -1,5)
#Two Dimmensions
#(x^2 + y^2) (P = [-1, -1])

function f(p::Vector{Float64})::Float64 
    return (p[1]^2 +p[2]^2)
end

#Find minimal value for function f(x)
function randomWalk(func::Function, point::Vector{Float64}, dim::Int64, maxIter::Int64, step::Float64, minStep::Float64)
    #Step 2 : Find function value in the starting point
    functValue = func(point)                   #function value in the start point
    nextValue = 0.0                            #next function value 
    vector = Vector{Float64}(undef, dim)       #shift vector with new point to check
    nextPoint = Vector{Float64}(undef, dim)    #next point to check
    #Step 3 : Set iteration number to 1
    i = 1                                      #loop iterator
    
    while(step >= minStep)
        #Step 4 : Draw a random vector from interval [-1, 1]. Length of the vector should be <= 1
        R = 2.0
        while (R >= 1.0)
            R = 0
            for j = 1:dim
                vector[j] = rand(Uniform(-1, 1))
                R = R + vector[j]^2
            end
            R = sqrt(R)
        end
        #Step 5 : Find new point value: Pn+1 = Pn + V*step and find f(p) value in that point
        for j = 1:dim
            nextPoint[j] = point[j] + vector[j] * step
        end
        nextValue = func(nextPoint)
        #Step 6 : If found value is smaller then privious value assign new values to point and functValue
        if (nextValue < functValue)
            functValue = nextValue
            for j = 1:dim
                point[j] = nextPoint[j]
            end
            #Step 6 -> Step 3 : Set iterator to 1
            i = 1
        else
            #Step 7 : Else If iterator didn`t reached maximal value, increment it
            if(i <= maxIter)
                i = i + 1
            else
                #Step 8 : Else calculate new step
                step = step / 2
            end
        end
    end
    #Print the optimal values
    println("Optimal point: ")
    println(point)
    println("Optimal value: ")
    println(functValue)
end

#Step 1 : Starting values
step = sqrt(2)
minStep = 0.1
maxIter = 10000
dim = 2
P = [-1.0, -1.0]

randomWalk(f, P, dim, maxIter, step, minStep);
