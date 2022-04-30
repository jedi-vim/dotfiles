vim.g.startify_lists = {
            { type = 'sessions',  header = { '  Sessions' } },
            { type = 'files', header = { '  MRU' } },
            { type = 'dir', header = { "   Current Directory "..vim.fn.getcwd()..":" } },
            { type = 'bookmarks', header = { '  Bookmarks' } },
            { type = 'commands',  header = { '  Commands' } }
}
