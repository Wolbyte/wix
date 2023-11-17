{lib, ...}:
with lib; {
  boolToNum = bool:
    if bool
    then 1
    else 0;

  mkGraphicalService = recursiveUpdate {
    Unit.PartOf = ["graphical-session.target"];
    Unit.After = ["graphical-session.target"];
    Install.WantedBy = ["graphical-session.target"];
  };
}
