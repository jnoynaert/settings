#removes current windows settings and establishes a hard symlink to the repo file

$proceed = Read-Host -prompt "Warning: script will destroy current settings for programs in the script. Continue? y/n"

if ($proceed = "y") {

    $runpath = $PSScriptRoot

    $old_ErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = "Stop"

    $old_VerbosePreference = $VerbosePreference
    $VerbosePreference = "continue"

    try {

        #VS code settings
        $vspath = "$env:APPDATA\Code\User"
        
        if (Test-Path -Path $vspath) {
            Write-Verbose "Removing old VS code settings..."
                try { Remove-Item "$vspath\keybindings.json", "$vspath\settings.json" } catch {}

            Write-Verbose "Symlinking VS code settings..."
                New-Item -ItemType HardLink -Path "$vspath\keybindings.json" -Value "$runpath\vs-code\keybindings.json"
                New-Item -ItemType HardLink -Path "$vspath\settings.json" -Value "$runpath\vs-code\settings.json"

            Write-Verbose "VS code settings finished. Don't forget to install the Shell Launcher extension and One Dark Pro theme!"
        } else {
            Write-Verbose "VS code not detected."
        }

        #Atom settings
        $atompath = "$HOME\.atom"
        
        if (Test-Path -Path $atompath) {
            Write-Verbose "Removing old Atom settings..."
                try { Remove-Item "$atompath\keymap.cson", "$atompath\config.cson" } catch {}

            Write-Verbose "Symlinking Atom settings..."
                New-Item -ItemType HardLink -Path "$atompath\keymap.cson" -Value "$runpath\atom\keymap.cson"
                New-Item -ItemType HardLink -Path "$atompath\config.cson" -Value "$runpath\atom\config.cson"

            Write-Verbose "Atom settings finished. Don't forget to install Hydrogen!"
        } else {
            Write-Verbose "Atom not detected."
        }

        #
        $juliapath = "$HOME\.julia"
        $juliaconfig = "$juliapath\config"

        if (Test-Path -Path $juliaconfig) {
            Write-Verbose "Removing old Julia startup file..."
                try {Remove-Item "$juliaStartupPath\startup.jl"} catch{}
        }

        if (Test-Path $juliapath) {
             Write-Verbose "Symlinking Julia settings..."
             New-Item -ItemType HardLink -Path "$juliaconfg\startup.jl" -Value "$runpath\julia\startup.jl"

            Write-Verbose "Julia settings finished. Don't forget to add either julia-vscode or the Atom packages language-julia, ident-detective, and latex-completions!"
        } else {
            Write-Verbose "Julia not detected."
        }
    }

    finally {
        $ErrorActionPreference = $old_ErrorActionPreference
        $VerbosePreference = $old_VerbosePreference
        Read-Host -prompt "Settings propagation finished. Press any key to continue"
    }

}

else {
    Write-Verbose "Cancelling..."
}