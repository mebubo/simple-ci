{ mkDerivation, aeson, base, servant, servant-server, stdenv, text
, wai, warp
}:
mkDerivation {
  pname = "simple-ci";
  version = "1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    aeson base servant servant-server text wai warp
  ];
  license = stdenv.lib.licenses.bsd3;
}
