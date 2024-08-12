# Welcome to my Neovim Config!

This repository sets up neovim for development, notetaking and text editing. The configuration is setup for both a windows and linux environment and uses the MYSYSTEM environment variable to enable/disable device specific options

Currently this config supports the following languages:
* c++
* python
* rust
* html
* nix
* css
* markdown
* latex
... and features :
* lsp
* autocompletion
* linting
* debugging
* obsidian support
* git support
... and more


## prerequisites
<!-- TODO : add nix-shell file for installing plugins -->
* node.js (npm)
* make
* cmake
* clang
* clangd
* ripgrep
* GNU diffutils

## setup

### general
add environment variable `MYSYSTEM`
example: 
MYSYSTEM = WinDesktop

### windows

#### 1. Setup PowerShell for use with neovim
- For an example see [my PowerShell profile](https://github.com/lwidm/powershell-profile)

#### 2. Fork this repo so that you have your own copy that you can modify

#### 3. Clone the newly created repo to the `~\AppData\Local` direcotry (creating `~\AppData\Local\nvim`)
```PowerShell
git clone https://github.com/lwidm/nvim $env:LOCALAPPDATA\nvim\
```

#### 4. Install node.js (npm) and add it to path
1. Download the pre-built installer for Node.js from the [official Node.js website](https://nodejs.org/en/download/prebuilt-installer).
2. Run the installer and follow the installation instructions.
3. Add Node.js to your system PATH. You can do this during the installation process or manually by modifying your environment variables.
    (For me the binary files are located at `C:\Program Files\nodejs`)

#### 5. Install GNU Make using GnuWin32
1. Download the GnuWin32 package for Make from [here](https://gnuwin32.sourceforge.net/packages/make.htm).
2. Install Make by running the installer.
3. Add Make to your system PATH. The default installation path usually is: `C:\Program Files (x86)\GnuWin32\bin`. 1. install make 
 2. install clang (using visual studio)

#### 6. Install CMake
1. Download the cmake installer from the [official website](https://cmake.org/download/)
2. Install CMake by running the installer.
3. Make sure CMake is added to your system PATH (this should happen during the installation process).

#### 7. Install clang, clangd and msvc using latest release of **Visual Studio Community Edition**
1. Download latest release of **Visual Studio Community Edition** from [here](https://visualstudio.microsoft.com)
2. Open the _Visual Studio Installer_ and go to the _Individual components_ tab
3. Select the following components
  * C++ Clang Compiler  for Windows
  * C++ CMake tools for Windows
  * MSVC vXXX - VS XXXX C++ ARM build tools (latest)
  * MSVC vXXX - VS XXXX C++ ARM Spectre-mitigated libs (latest)
  * MSVC vXXX - VS XXXX C++ ARM64/ARM64EC build tools (latest)
  * MSVC vXXX - VS XXXX C++ ARM64/ARM64EC Spectre-mitigated libs (latest)
  * MSVC vXXX - VS XXXX C++ x64/x86 build tools (latest)
  * MSVC vXXX - VS XXXX C++ x64/x86 Spectre-mitigated libs (latest)
  * Windows 11 SDK
  * MSBuild support for LLVM (clang-cl) toolset
4. Add installed tools to PATH
this could be `C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools`

#### 8. install clangd (maybe the previous step already does this):

#### 9. install ripgrep
run the following command:
```PowerShell
winget install BurntSushi.ripgrep.MSVC
```

#### 10. Install GNU diffutils (for undotree)
