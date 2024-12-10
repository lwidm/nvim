# Welcome to my Neovim Config!

This repository sets up neovim for development, note taking and text editing. The configuration is set up both for a Windows and a Linux environment and uses the MYSYSTEM environment variable to enable/disable device specific options.

Currently this config supports the following languages:

- c++
- python
- rust
- html
- nix
- css
- markdown
- latex

... and features:

- lsp
- autocompletion
- linting
- debugging
- obsidian support
- git support

... and more

## prerequisites

<!-- TODO : add nix-shell file for installing plugins -->

- node.js (npm)
- make
- cmake
- clang
- clangd
- rust (cargo/rustup)
- ripgrep
- GNU diffutils
- latexmk (can be installed through texliveFull)

### Linux prerequisites

- zanthura

### Windows prerequisites

- sumatraPDF
  - you need to add it to PATH (typically under `~\AppData\Local\SumatraPDF`

## non lazy - priority loading

| plugin                        | file path                       | priority |
| ----------------------------- | ------------------------------- | -------- |
| `catppuccin/nvim`             | `lwidm/plugins/colorscheme.lua` | 1001     |
| `nvim-tree/nvim-web-devicons` | `lwidm/plugins/init.lua`        | 1000     |

## Setup

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

#### 6. Install CMake

1. Download the Cmake installer from the [official website](https://cmake.org/download/)
2. Install CMake by running the installer.
3. Make sure CMake is added to your system PATH (this should happen during the installation process)

#### 7. Install zig compiler
- follow guide on [official website](https://ziglang.org/learn/getting-started/#installing-zig)
- I recommand winget: `winget install -e --id zig.zig`

#### 8. Install clang, clangd and msvc using latest release of **Visual Studio Community Edition**

1. Download latest release of **Visual Studio Community Edition** from [here](https://visualstudio.microsoft.com)
2. Open the _Visual Studio Installer_ and go to the _Individual components_ tab
3. Select the following components

- C++ Clang Compiler for Windows
- C++ CMake tools for Windows
- MSVC vXXX - VS XXXX C++ ARM build tools (latest)
- MSVC vXXX - VS XXXX C++ ARM Spectre-mitigated libs (latest)
- MSVC vXXX - VS XXXX C++ ARM64/ARM64EC build tools (latest)
- MSVC vXXX - VS XXXX C++ ARM64/ARM64EC Spectre-mitigated libs (latest)
- MSVC vXXX - VS XXXX C++ x64/x86 build tools (latest)
- MSVC vXXX - VS XXXX C++ x64/x86 Spectre-mitigated libs (latest)
- Windows 11 SDK
- MSBuild support for LLVM (clang-cl) toolset

4. Add installed tools to PATH

- `C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\Llvm\bin`
- `C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.40.33807\bin\Hostx64\x64`
- `C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin`

5. Set CC and CXX environment variables

- CC: `C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\Llvm\bin\clang.exe`
- CXX: `C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\Llvm\bin\clang++.exe`

#### 9. Install clangd (maybe the previous step already does this):

#### 10. Install Rust (cargo) and add it to path

1. Install Rust by following the instructions on the [official Rust website](https://doc.rust-lang.org/cargo/getting-started/installation.html).
2. During installation, you might need to install C++ tools from Visual Studio. If prompted, follow the instructions to install the necessary components.

#### 11. Install ripgrep

run the following command:

```PowerShell
winget install BurntSushi.ripgrep.MSVC
```

#### 12. Install SumatraPDF

1. Install from [the official webiste](https://www.sumatrapdfreader.org/download-free-pdf-viewer)
2. Add binaries to PATH (typically found at `~\AppData\Local\sumatraPDF`)

#### 13. Add Mason binaries to path

(usally located at C:\Users\lukas\AppData\Local\nvim-data\mason\bin)

#### 14. Install GNU diffutils (for undotree)

### Issues

#### TreeSitter not working for <language>

- Reinstall lua parser by running `:TSInstall <languaga>`
- Where Language can be:
  - `lua`
  - `markdown`

#### Fortran

- fortran77 nvim-web-devicons not working
