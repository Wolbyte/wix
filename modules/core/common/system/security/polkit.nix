{
  config,
  lib,
  ...
}:
with lib; {
  security.polkit = {
    enable = true;
    debug = true;

    extraConfig = mkIf config.security.polkit.debug ''
      /* Log authorization checks. */
      polkit.addRule(function(action, subject) {
        polkit.log("user " +  subject.user + " is attempting action " + action.id + " from PID " + subject.pid);
      });
    '';
  };
}
