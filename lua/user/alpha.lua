local M = {
  "goolord/alpha-nvim",
  event = "VimEnter",
}

function M.config()
  local alpha = require "alpha"
  local dashboard = require "alpha.themes.dashboard"
  dashboard.section.header.val = {
    [[     j████  j████             ,▄▓██████▌▄     _█████▌       ▓████▌                                       ▐██████████▓▄_ ]],
    [[       _▐█▓▓▓█b_            ╓█████▀▀▀█████▌    ██████▄    _▓█████▌                                       ▐████▀▀▀▀█████⌐]],
    [[╥╫███▓▄▓▀_____▓▓▄████▄µ    ▄███▓       ╙████   ███████Q  _▓██████▌                                __     ▐███µ     ╟███b]],
    [[╙╙  @▓╙_       └╙▓▄  ╙╙    ████         ▐███▌  ████╫███⌐ ╫███▐███▌   ]▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓⌐  ▓███▄    ▐████▓▓▓▓████▀]],
    [[    ╫█          _█▌        ████_        j███▌  ████_╫███▄███─]███▌   └▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀⌐  ▓███▀    ▐████████████▌]],
    [[    ╫█__         █▌        ╫███▌_      ,████¬  ████  ▓█████╜ ]███▌                                       ▐███µ     _███▌]],
    [[ ╒▄▄▄▄▀▄▄     ▄╫▀▄▄▄▄⌐      ▀████▓▄▄▄▄█████─   ████   ████▀  ]███▌                                       ▐███▌▄▄▄▄▄████▌]],
    [[▓▌╙╙╙└ └╟█████╩└ └╙╙╙▓▌      _╙▀████████▀└    _████   _██▌_  ]███▌                                       ▐███████████▀╙]],
  }
  dashboard.section.buttons.val = {
    dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
    dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("p", " " .. " Find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
    dashboard.button("r", "󰄉 " .. " Recent files", ":Telescope oldfiles <CR>"),
    dashboard.button("t", " " .. " Find text", ":Telescope live_grep <CR>"),
    dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
    dashboard.button("q", " " .. " Quit", ":qa<CR>"),
  }
  local function footer()
    return "Let's survive to this day, shall we?"
  end

  dashboard.section.footer.val = footer()

  dashboard.section.footer.opts.hl = "Type"
  dashboard.section.header.opts.hl = "Include"
  dashboard.section.buttons.opts.hl = "Keyword"

  dashboard.opts.opts.noautocmd = true
  alpha.setup(dashboard.opts)
end

return M
