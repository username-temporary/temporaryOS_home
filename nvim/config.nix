{pkgs,lib,inputs,...}:
{
 #imports=
 #[  inputs.nvf.nixosModules.default ];
  programs.nvf={
    enable=true;
    settings.vim={

     statusline.lualine.enable = true;
     telescope.enable = true;
     lsp.enable=true;
      languages={
        enableTreesitter = true;
        nix.enable = true;
        clang={
         enable=true; 
         lsp.enable=true;
        };

       
      };
     treesitter.indent.enable=false;
      options = {
        tabstop = 2;
        shiftwidth = 2;
        softtabstop = 2;
        expandtab = true;

        autoindent = true;
        smartindent = true;
     };
    };
  };
}
