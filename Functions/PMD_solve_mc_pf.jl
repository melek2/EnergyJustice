using PowerModelsDistribution
using Ipopt

function PMD_solve_mc_pf(data_file::String)
    # Define the optimizer with attributes
    ipopt_solver = optimizer_with_attributes(Ipopt.Optimizer, "print_level" => 0, "tol" => 1e-6)
    
    # Set the power model formulation
    formulation = ACPUPowerModel
    
    # Solve the power flow problem and return the result
    result = solve_mc_pf(data_file, formulation, ipopt_solver)
    
    return result
end
