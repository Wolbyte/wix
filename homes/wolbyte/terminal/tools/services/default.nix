{
  imports = [
    ./gpg
  ];

  config = {
    services.udiskie.enable = true;
  };
}
