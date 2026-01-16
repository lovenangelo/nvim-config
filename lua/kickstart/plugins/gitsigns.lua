-- Adds git related signs to the gutter, as well as utilities for managing changes
-- NOTE: gitsigns is already included in init.lua but contains only the base
-- config. This will add also the recommended keymaps.
return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        -- ]c - Jump to next changed hunk (like next git change in file)
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        -- [c - Jump to previous changed hunk
        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions - Visual mode
        -- <leader>hs - Stage selected lines (like: git add --patch)
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [s]tage hunk' })

        -- <leader>hr - Reset selected lines to HEAD (undo changes)
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [r]eset hunk' })

        -- Actions - Normal mode
        -- <leader>hs - Stage hunk under cursor (like: git add --patch)
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })

        -- <leader>hr - Reset hunk under cursor (undo changes)
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })

        -- <leader>hS - Stage entire buffer (like: git add <file>)
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })

        -- <leader>hu - Undo last stage (unstage hunk)
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })

        -- <leader>hR - Reset entire buffer to HEAD (undo all changes in file)
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })

        -- <leader>hp - Preview hunk changes in floating window
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })

        -- <leader>hb - Show git blame for current line
        map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })

        -- <leader>hd - Diff current file against index (like: git diff)
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })

        -- <leader>hD - Diff against last commit (like: git diff HEAD~1)
        map('n', '<leader>hD', function()
          gitsigns.diffthis '@'
        end, { desc = 'git [D]iff against last commit' })

        -- Toggles
        -- <leader>tb - Toggle inline git blame on current line
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })

        -- <leader>tD - Toggle showing deleted lines inline
        map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
      end,
    },
  },
}
