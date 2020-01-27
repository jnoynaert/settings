#removes current windows settings and establishes a hard symlink to the repo file
$compile_julia_sysimage = $false

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

            Write-Verbose "Adding extensions..."
                code --install-extension zhuangtongfa.material-theme #onedark pro
                code --install-extension tyriar.shell-launcher
                code --install-extension julialang.language-julia

            Write-Verbose "VS code settings & extensions finished."
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

        #Julia settings
        $juliapath = "$HOME\.julia"
        $juliaconfig = "$juliapath\config"

        if (Test-Path -Path $juliapath) {

            #if julia present but config directory is not:
            if (-Not (Test-Path -Path $juliaconfig)) {

                Write-Verbose "Adding config folder to Julia install..."
                    mkdir $juliaconfig

            } else {

                Write-Verbose "Removing old Julia startup file..."
                    try {Remove-Item "$juliaconfig\startup.jl"} catch{}

            }
            
            Write-Verbose "Symlinking Julia settings..."
                New-Item -ItemType HardLink -Path "$juliaconfig\startup.jl" -Value "$runpath\julia\startup.jl"

            if ($compile_julia_sysimage) {
                
                Write-Verbose "Attempting to compile sysimage..."
                try {julia -e 'using Pkg; Pkg.add("WinRPM"); using WinRPM; WinRPM.install("gcc")'} catch { Write-Verbose "Error adding GCC"}
                try {julia -e 'using Pkg; Pkgd.add("PackageCompiler"); using PackageCompiler; force_native_image!()'} catch { Write-Verbose "Error compiling Julia sysimage"}

            } else {

                Write-Verbose "Not attempting to compile julia sysimage..."
            }


            Write-Verbose "Julia settings finished. If using Atom/Hydrogen, you'll need language-julia, ident-detective, and latex-completions."

        } else {

            Write-Verbose "Julia not detected."
        }

        #Jupyter lab settings
        $jupyterpath = "$HOME\.jupyter\lab"
        $jupyterconfig = "$jupyterpath\user-settings\"

        if (Test-Path -Path $jupyterpath) {

            #if jupyter present but config directory is not:
            if (-Not (Test-Path -Path $jupyterconfig)) {

                Write-Verbose "Adding config folder to Jupyter install..."
                    mkdir $jupyterconfig

            } else {

                Write-Verbose "Removing old Jupyter settings folder..."
                    try {Remove-Item "$jupyterconfig\@jupyterlab" -Recurse -Force} catch{}

            }
            
            Write-Verbose "Symlinking Jupyter settings..."
                New-Item -ItemType HardLink -Path "$jupyterconfig\@jupyterlab\" -Target "$runpath\jupyter-lab\@jupyterlab\"

            Write-Verbose "Jupyter settings finished."

        } else {

            Write-Verbose "Jupyter not detected."
        }

        #Windows terminal settings
        $terminalconfig = "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\profiles.json"
        if (Test-Path -Path $terminalconfig) {

            Write-Verbose "Symlinking Windows terminal settings..."
                New-Item -ItemType Junction -Path $terminalconfig -Target "$runpath\windows-terminal\profiles.json"

            Write-Verbose "Windows terminal settings finished."

        } else {

            Write-Verbose "Windows terminal not detected."
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