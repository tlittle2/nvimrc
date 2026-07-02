local inBrackets = function(k)
  return "<" .. k .. ">"
end

local leader = inBrackets("leader")


return {
  loop = function(tbl, callback)
    for k, v in pairs(tbl) do
      callback(k,v)
    end
  end,

   vim = {
      mode = {
          normal = 'n',
          visual = 'v',
          terminal = 't',
          insert = 'i',
      },

      key = {
        ctrl = function(k)
          return inBrackets("C-" .. k)
        end,

        alt = function(k)
          return inBrackets("A-" .. k)
        end,
      },

      leader = leader,

      prefixLeader = function(keymap)
          return leader .. keymap
      end,

      runVimCommand = function(command)
          return "<cmd>" .. command .. "<CR>"
      end,

      maxPriority = math.maxinteger,
      minPriority = math.mininteger
  },

  string = {
    sQuote = function(ip)
      return "'" .. ip .. "'"
    end,

    dQuote = function(ip)
      return '"' .. ip .. '"'
    end,

    inBrackets = function(k)
      return inBrackets(k)
    end
  },
}

