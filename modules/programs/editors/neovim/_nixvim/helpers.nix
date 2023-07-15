rec {
  mkKeybind = action: desc: lua: {inherit action desc lua;};
  mkLuaKeybind = action: desc: mkKeybind action desc true;
  mkCmdKeybind = action: desc: mkKeybind "<cmd>${action}<CR>" desc false;
}
