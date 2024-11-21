using CSV, DataFrames

function process_bus_data(results::Dict, file_name::String = "")
    bus_names = [bus_id for (bus_id, bus_data) in results["solution"]["bus"]]
    
    # Initialize DataFrame with missing values
    df = DataFrame(Bus = bus_names, 
                   VM_1 = missing, VA_1 = missing, 
                   VM_2 = missing, VA_2 = missing, 
                   VM_3 = missing, VA_3 = missing)

    # Convert columns to appropriate types
    df.VM_1 = convert(Vector{Union{Missing, Float64}}, df.VM_1)
    df.VA_1 = convert(Vector{Union{Missing, Float64}}, df.VA_1)
    df.VM_2 = convert(Vector{Union{Missing, Float64}}, df.VM_2)
    df.VA_2 = convert(Vector{Union{Missing, Float64}}, df.VA_2)
    df.VM_3 = convert(Vector{Union{Missing, Float64}}, df.VM_3)
    df.VA_3 = convert(Vector{Union{Missing, Float64}}, df.VA_3)

    # Loop through each bus in the result to fill in the voltages
    for (bus_id, bus_data) in results["solution"]["bus"]
        # Get the row corresponding to the bus
        row_index = findfirst(df[!, "Bus"] .== bus_id)
        # Access the VM and VA arrays for the bus
        vm = bus_data["vm"]
        va = bus_data["va"]

        # Check the number of phases (length of VA or VM)
        phase = length(va)

        # Depending on the number of phases, update the relevant columns
        if phase == 3
            df[row_index, "VM_1"] = vm[1]
            df[row_index, "VA_1"] = va[1]
            df[row_index, "VM_2"] = vm[2]
            df[row_index, "VA_2"] = va[2]
            df[row_index, "VM_3"] = vm[3]
            df[row_index, "VA_3"] = va[3]
        elseif phase == 2
            df[row_index, "VM_1"] = vm[1]
            df[row_index, "VA_1"] = va[1]
            df[row_index, "VM_2"] = vm[2]
            df[row_index, "VA_2"] = va[2]
            df[row_index, "VM_3"] = missing
            df[row_index, "VA_3"] = missing
        else
            df[row_index, "VM_1"] = vm[1]
            df[row_index, "VA_1"] = va[1]
            df[row_index, "VM_2"] = missing
            df[row_index, "VA_2"] = missing
            df[row_index, "VM_3"] = missing
            df[row_index, "VA_3"] = missing
        end
    end

    # If a file name is provided, save DataFrame to a CSV file
    if file_name != ""
        CSV.write(file_name, df)
    end

    return df
end