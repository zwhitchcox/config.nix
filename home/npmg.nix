{ lib, config, ...}:
{
  home.file.".npmrc".text = ''
    prefix=/home/${config.home.user-info.username}/.mutable_node_modules
  '';
}
