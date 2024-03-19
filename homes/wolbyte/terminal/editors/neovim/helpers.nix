rec {
  mkKeymap = key: mode: action: options: lua: {
    inherit key mode action options lua;
  };

  mkRawKeymap = key: mode: action: options: mkKeymap key mode action options false;
  mkLuaKeymap = key: mode: action: options: mkKeymap key mode action options true;
  mkCmdKeymap = key: mode: action: options: mkKeymap key mode "<CMD>${action}<CR>" options false;
}
