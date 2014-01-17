{ cabal, aeson, conduit, dataDefault, fastLogger, hamlet, hjsmin
, httpConduit, monadControl, monadLogger, shakespeareCss
, shakespeareJs, shakespeareText, split, text, utf8String, waiExtra
, waiHandlerFastcgi, waiLogger, warp, yaml, yesod, yesodAuth
, yesodCore, yesodForm, yesodStatic
}:

cabal.mkDerivation (self: {
  pname = "tobias-cgroup-manager";
  version = "0.0.1";
  src = "/root/tobias-cgroup.tar.gz";
  sha256 = "380f65b29134915ff9b007abf795ec5b";
  isLibrary = true;
  isExecutable = false;
  buildDepends = [
    aeson conduit dataDefault fastLogger hamlet hjsmin httpConduit
    monadControl monadLogger shakespeareCss shakespeareJs
    shakespeareText split text utf8String waiExtra waiHandlerFastcgi
    waiLogger warp yaml yesod yesodAuth yesodCore yesodForm yesodStatic
  ];
  meta = {
    platforms = self.ghc.meta.platforms;
  };
})

