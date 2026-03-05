# Welcome to my Neovim Config!

This repository sets up neovim for development, note taking and text editing. The configuration is set up both for a Windows and a Linux environment and uses the `MYSYSTEM` environment variable to enable/disable device specific options.

## Clone

```zsh
git clone git@github.com:lwidm/nvim.git ~/.config/nvim
```

## Supported languages

- c++
- python
- rust
- html
- nix
- css
- markdown
- latex

## Features

- lsp
- autocompletion
- linting
- debugging
- obsidian support
- git support

---

## Prerequisites

### Arch
```zsh
sudo pacman -S nodejs npm make cmake clang clang-tools-extra rustup ripgrep fd diffutils lazygit python zathura texlive-full zip unzip sshfs fzf xdotool biber
```
After installing rustup:
```zsh
rustup default stable
source $HOME/.cargo/env
```

### Debian
```zsh
sudo apt install -y \
  nodejs npm make cmake clang clangd \
  ripgrep fd-find diffutils python3 python3-pip \
  zathura texlive-full zip unzip sshfs fzf \
  xdotool biber python3-venv
```
Install rustup:
```zsh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
```
Install lazygit manually (not in apt) — see [lazygit releases](https://github.com/jesseduffield/lazygit/releases).

### OpenSUSE Tumbleweed
```bash
sudo zypper in nodejs npm make cmake clang ripgrep fd diffutils python3 python3-pip zathura zathura-plugin-pdf-poppler texlive-scheme-full texlive-biber zip unzip sshfs fzf xdotool lazygit
```
Install rustup:
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env # <- add this to your .zshrc / .bashrc / etc.
```

### Windows

#### 1. Setup PowerShell for use with neovim
- For an example see [my PowerShell profile](https://github.com/lwidm/powershell-profile)

#### 2. Fork this repo so that you have your own copy that you can modify

#### 3. Clone the newly created repo to `~\AppData\Local\nvim`
```PowerShell
git clone https://github.com/lwidm/nvim $env:LOCALAPPDATA\nvim\
```

#### 4. Install node.js (npm) and add it to PATH
1. Download the pre-built installer from the [official Node.js website](https://nodejs.org/en/download/prebuilt-installer)
2. Run the installer and follow the instructions
3. Add Node.js to PATH (binaries typically at `C:\Program Files\nodejs`)

#### 5. Install GNU Make using GnuWin32
1. Download from [GnuWin32](https://gnuwin32.sourceforge.net/packages/make.htm)
2. Add to PATH (default: `C:\Program Files (x86)\GnuWin32\bin`)

#### 6. Install CMake
1. Download from the [official website](https://cmake.org/download/)
2. Ensure CMake is added to PATH during installation

#### 7. Compilers for treesitter
- zig: `winget install -e --id zig.zig`
- llvm: `winget install llvm` (elevated PowerShell)

#### 8. Install clang, clangd and MSVC via Visual Studio Community Edition
1. Download [Visual Studio Community Edition](https://visualstudio.microsoft.com)
2. In the _Visual Studio Installer_ go to _Individual components_ and select:
   - C++ Clang Compiler for Windows
   - C++ CMake tools for Windows
   - MSVC vXXX - VS XXXX C++ x64/x86 build tools (latest)
   - MSVC vXXX - VS XXXX C++ x64/x86 Spectre-mitigated libs (latest)
   - MSVC vXXX - VS XXXX C++ ARM build tools (latest)
   - MSVC vXXX - VS XXXX C++ ARM Spectre-mitigated libs (latest)
   - MSVC vXXX - VS XXXX C++ ARM64/ARM64EC build tools (latest)
   - MSVC vXXX - VS XXXX C++ ARM64/ARM64EC Spectre-mitigated libs (latest)
   - Windows 11 SDK
   - MSBuild support for LLVM (clang-cl) toolset
3. Add to PATH:
   - `C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\Llvm\bin`
   - `C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.40.33807\bin\Hostx64\x64`
   - `C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin`
4. Set environment variables:
   - `CC`: `C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\Llvm\bin\clang.exe`
   - `CXX`: `C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\Llvm\bin\clang++.exe`

#### 9. Install Rust (cargo)
Follow the [official Rust guide](https://doc.rust-lang.org/cargo/getting-started/installation.html).

#### 10. Install ripgrep
```PowerShell
winget install BurntSushi.ripgrep.MSVC
```

#### 11. Install SumatraPDF
1. Install from [the official website](https://www.sumatrapdfreader.org/download-free-pdf-viewer)
2. Add to PATH (typically `~\AppData\Local\SumatraPDF`)

#### 12. Install lazygit
```PowerShell
winget install lazygit
```

#### 13. Install GNU diffutils (for undotree)

#### 14. Add Mason binaries to PATH
Usually located at `C:\Users\lukas\AppData\Local\nvim-data\mason\bin`

---

## Setup

### MYSYSTEM environment variable
Set the `MYSYSTEM` environment variable to match your system. Valid values:
- `ArchDesktop` / `ArchLaptop`
- `DebianDesktop` / `DebianLaptop`
- `OpenSuseDesktop` / `OpenSuseLaptop`
- `wslDebianDesktop` / `wslDebianLaptop`
- `WinDesktop` / `WinLaptop`

### Cargo path
Make sure `~/.cargo/bin` is in your PATH:
```zsh
source $HOME/.cargo/env
```

### Magma / Jupyter
Use `pip3` in all cases:
```zsh
pip3 install pynvim jupyter_client Pillow cairosvg pnglatex plotly kaleido pyperclip
```

### vim-jukit (Windows)
- Make sure `python3` is executable (e.g. via alias in PowerShell profile):
  ```PowerShell
  New-Alias -Name python3 -Value python
  ```
- Make sure python is available to neovim:
  ```zsh
  pip install pynvim
  ```

---

## Non-lazy priority loading

| plugin                        | file path                       | priority |
| ----------------------------- | ------------------------------- | -------- |
| `catppuccin/nvim`             | `lwidm/plugins/colorscheme.lua` | 1001     |
| `nvim-tree/nvim-web-devicons` | `lwidm/plugins/init.lua`        | 1000     |

---

# Possible Bugs

### TreeSitter not working for \<language\>
Reinstall the parser:
```
:TSInstall <language>
```
Common ones: `lua`, `markdown`

### Fortran
- fortran77 nvim-web-devicons not working
