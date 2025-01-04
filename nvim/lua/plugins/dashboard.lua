local header = [[
           █            
         ███            
       ████             
     █████              
   █████                
 █████      ▒           
▒▒▒▒        ▒▒          
  ▒▒▒▒      ▒▒▒▒        
    ▒▒▒▒      ▒▒▒▒      
      ▒▒▒▒      ▒▒▒▒    
        ▒▒▒▒      ▒▒▒▒  
          ▒▒        ▒▒▒▒
           ▒      █████ 
                █████   
              █████     
             ████       
            ███         
            █           
]]
return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = header,
        },
        sections = {
          { section = "header", width = 10 },
          {
            pane = 2,
            section = "terminal",
            cmd = [[echo -n "






                        |                                
   _` |  |  |  |  |      _|   _| |  |   _ \    \    _` | 
 \__, | \_,_| \_, | _) \__| _|  \_,_| \___/ _| _| \__, | 
     _|       ___/                                ____/  
"]],
            height = 19,
            padding = 1,
          },
          { section = "keys", gap = 1 },
          { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
    },
  },
}
