{ pkgs, lib, inputs, ... }:

{
  programs.nixvim = {
    enable = true;

    # Options
    options = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };
    
    # Autoexec
    autoCmd = [
      {
	event = [ "BufEnter" "BufWinEnter" ];
	command = "set conceallevel=2";
      }
    ];
    
    # Clipboard
    clipboard = {
      register = "unnamedplus";
      providers = {
	wl-copy.enable = true;
      };
    };

    # Keybindings
    keymaps = [
      # File Search via Telescope
      {
        key = "ff";
        action = "<cmd>Telescope find_files theme=dropdown hidden=true no_ignore=true<cr>";
      }
      
      # Code Search via Telescope
      {
        key = "fg";
	action = "<cmd>Telescope live_grep<cr>";
      }

      # Toggle Terminal
      {
        key = "tt";
	action = "<cmd>ToggleTerm direction=float<cr>";
      }
      {
	mode = "t";
	key = "<esc>";
	action = "<cmd>ToggleTerm direction=float<cr>";
      }

      # Previous Buffer
      {
	key = ",";
	options.silent = true;
      	action = "<Cmd>BufferPrevious<CR>";
      }

      # Next Buffer
      {
        key = ".";
	options.silent = true;
      	action = "<Cmd>BufferNext<CR>";
      }
    ];	

    # Theme
    colorschemes.catppuccin = {
      enable = true;
      flavour = "macchiato";
    };

    # Plugins
    plugins = {
      lualine = {
      	enable = true;
      	# theme = "bubbles";
      };

      # Alpha
      alpha = {
        enable = true;
        layout = [
          {
            type = "padding";
            val = 2;
          }
          {
            opts = {
              hl = "Type";
              position = "center";
            };
            type = "text";
            val = [
              "  ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗  "
              "  ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║  "
              "  ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║  "
              "  ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║  "
              "  ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║  "
              "  ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝  "
            ];
          }
          {
            type = "padding";
            val = 2;
          }
          {
            type = "group";
            val = [
              {
                command = "<CMD>ene<CR>";
                desc = "New file";
                shortcut = "1";
              }
	      {
		command = ":e ~/.config/home-manager/neovim.nix<CR>";
                desc = "Open Config";
	      	shortcut = "2";
	      }
              {
                command = ":qa<CR>";
                desc = "Quit Neovim";
                shortcut = "3";
              }
            ];
          }
          {
            type = "padding";
            val = 2;
          }
        ];
      };

      # Neorg
      neorg = {
	      enable = true;
      	modules = {
	        "core.defaults" = {
	        __empty = null;
	        };
      	  "core.concealer" = {
	        config = {
	          folds = true;
	          icon_preset = "basic";
	          conceallevel = 2;
	        };
	      };
	      "core.integrations.treesitter" = {
	        config = {
	          configure_parsers = true;
	          install_parsers = true;
	        };
     	  };
	      "core.dirman" = {
	        config = {
	          default_workspace = "notes";
	          workspaces = {
         		  notes = "/home/poacher/notes/";
	          };
	        };
	      };
	      "core.summary" = {
	        config = {
	          strategy = "default";
	        };
	      };
   	    "core.completion" = {
	        config = {
	          engine = "nvim-cmp";
	        };
	      };
	      "core.export" = {
	        __empty = null;
	      };
    	};
    };
      
      # LSP
      lsp = {
        servers = {
	  nixd.enable = true;
	  java-language-server.enable = true;
	  bashls.enable = true;
	  pyright.enable = true;
	  rust-analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
	};
	enable = true;
      };
      nvim-cmp = {
       	enable = true;
	  sources = [ 
	    { 
	      name = "nvim_lsp"; 
            }
	    {
	      name = "luasnip";
            }
	    {
	      name = "copilot-vim";
	    }
	  ];
	  mapping = {
	    "<CR>" = "cmp.mapping.confirm({ select = true })";
	    "<Tab>" = {
	    action = ''
	    function(fallback)
	      if cmp.visible() then
		cmp.select_next_item()
	      else
		fallback()
	      end
	    end
	    '';
	    modes = [
	      "i"
	      "s"
	    ];
	  };
	};
      };
       
      # Copilot # broken
      copilot-vim = {
      	enable = true;
      	filetypes = {
	  "markdown" = false;
	  "norg" = false;
      	};
      };

      # Notifications
      notify = {
        enable = true;
        fps = 30;
        stages = "slide";
      };

      # Java LSP
      nvim-jdtls = {
	enable = true;
	data =  "./jdtls";
      };

      # Misc Plugins
      telescope.enable = true; # Fuzzy Search
      auto-save.enable = true; # Autosaving
      treesitter.enable = true; # Fancy Highlighting
      comment-nvim.enable = true; # Auto commenting
      todo-comments.enable = true; # Fancy todo Comments
      barbar.enable = true; # Top Bar
      luasnip.enable = true; # Clipboard
      toggleterm.enable = true; # Toggleterm
      nvim-colorizer.enable = true; # Colorize Hex Codes
      neogit.enable = true; # Git
      indent-blankline.enable = true;
      markdown-preview.enable = true;
    };

    # Dependencies for plugins
    extraPackages = with pkgs; [
      ripgrep
    ];

    # Plugins not found in the nixvim repo
    extraPlugins = with pkgs.vimPlugins; [
      vim-sleuth
    ];

    extraConfigLua = ''
    '';
  };
}
