# Dotfiles

My personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

Each application has its own package directory:

```
dotfiles/
├── nvim/          # Neovim configuration
└── tmux/          # Tmux configuration  
```

## Prerequisites

- [GNU Stow](https://www.gnu.org/software/stow/)
- [TPM (Tmux Plugin Manager)](https://github.com/tmux-plugins/tpm)

## Installation

1. **Clone this repository:**
   ```bash
   git clone <your-repo-url> ~/dotfiles
   cd ~/dotfiles
   ```

2. **Install TPM (for tmux plugins):**
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```

3. **Stow the configurations you want:**
   ```bash
   # Individual packages
   stow nvim
   stow tmux
   
   # Or multiple at once
   stow nvim tmux 
   ```

4. **Install tmux plugins:**
   - Start tmux: `tmux`
   - Press `Ctrl-a + Shift-i` to install plugins

## Usage

### Adding new configurations
1. Create a new package directory (e.g., `alacritty/`)
2. Mirror your home directory structure inside it
3. Stow it: `stow alacritty`

### Removing configurations
```bash
stow -D nvim  # Remove nvim symlinks
```

### Updating
```bash
git pull
# Restow if needed
stow nvim
```

## Key Features

### Tmux
- Prefix key: `Ctrl-a`
- Vim-style pane navigation: `Ctrl-hjkl`
- Plugins: vim-tmux-navigator, tmux-resurrect, tmux-continuum

### Neovim
- Custom configuration with plugins
- LSP support and modern editing features

## Notes

- Plugin directories (`.tmux/plugins/`, etc.) are not tracked in git
- Each package can be managed independently
- Configurations are symlinked, so changes are immediately reflected in the repo
