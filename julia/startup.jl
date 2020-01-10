using REPL

atreplinit() do repl
    # auto-load Revise.jl
    #=
    try
        @eval using Pkg
        haskey(Pkg.installed(), "Revise") || @eval Pkg.add("Revise")
    catch
    end
    try
        @eval using Revise
        @async Revise.wait_steal_repl_backend()
    catch
    end
    =#
    
    
    # Fix nightmare pasting into the windows repl (as of v1.1)
    if isdefined(repl, :options)
        repl.options = REPL.Options(auto_indent=false) 
    end

     # Printing function for arrays
    @eval showall(array) = show(IOContext(stdout, :limit=>false), MIME"text/plain"(), array)
end