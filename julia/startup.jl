using REPL

atreplinit() do repl
    if isdefined(repl, :options)
        repl.options = REPL.Options(auto_indent=false)
    end
end