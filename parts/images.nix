{ self, ... }:
{
  flake.images =
    let
      eileen = self.nixosConfigurations."eileen";
    in
    {
      eileen = eileen.config.system.build.isoImage;
    };
}
