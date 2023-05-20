# auto-nvimrc

Executes `.nvimrc` and `.nvimrc.lua` files from the current and parent directories.

Prompts the user to trust the files before executing them.

## Setup

[lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
    "Gelio/auto-nvimrc",
    config = function()
        local auto_nvimrc = require("auto-nvimrc")
        auto_nvimrc.execute_nvimrcs()

        vim.api.nvim_create_user_command("AutoNvimrcReset", function()
            auto_nvimrc.reset()
        end, {})
    end,
}
```
