using JuMP, HiGHS


A = [1, 1, 1, 1, 1, 1, 1]   
c = [1, 2, 3, 4, 5, 6, 7]   
b = 4                       

n = length(A)  

# Model def
LPmodel = Model(HiGHS.Optimizer)

# Variable def
@variable(LPmodel, x[1:n] >= 0)

# Constraint def
@constraint(LPmodel, demand, sum(A[i] * x[i] for i in 1:n) <= b)

# Obj function
@objective(LPmodel, Max, sum(c[i] * x[i] for i in 1:n))

# Solve!!!
optimize!(LPmodel)

# Results
println("\nSelected x values (fractional):\n", value.(x))
println("Objective value (maximum value of selected items): ", objective_value(LPmodel))
