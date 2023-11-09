{lib, ...}:
with lib; rec {
  mkKeybind = action: desc: lua: {inherit action desc lua;};
  mkLuaKeybind = action: desc: mkKeybind action desc true;
  mkCmdKeybind = action: desc: mkKeybind "<cmd>${action}<CR>" desc false;

  mkKeymap = action: desc: lua: {
    inherit action lua;
    options = {inherit desc;};
  };
  mkLuaMap = action: desc: mkKeymap action desc true;
  mkCmdMap = action: desc: mkKeymap "<cmd>${action}<CR>" desc false;
  mkRawMap = action: desc: mkKeymap action desc false;

  mkKeymaps = {
    n ? {},
    i ? {},
    v ? {},
    x ? {},
    t ? {},
    c ? {},
    nvo ? {},
  } @ args:
    mkMerge (
      mapAttrsToList (
        mode:
          mapAttrsToList (key: props: {inherit key mode;} // props)
      )
      args
    );
}
