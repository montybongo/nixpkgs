cabal.mkDerivation (self: {
  pname = "tobias-cgroup-manager";
  version = "0.0.1";
  sha256 = "18d536186b75ed5efdb754ab272a350a";
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    aeson conduit dataDefault fastLogger hamlet hjsmin httpConduit
    monadControl monadLogger shakespeareCss shakespeareJs
    shakespeareText split text utf8String waiExtra waiHandlerFastcgi
    waiLogger warp yaml yesod yesodAuth yesodCore yesodForm yesodStatic
  ];
  meta = {
    license = self.stdenv.lib.licenses.proprietary;
    platforms = self.ghc.meta.platforms;
  };
})