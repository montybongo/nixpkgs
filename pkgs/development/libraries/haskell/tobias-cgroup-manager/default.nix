{ cabal, aeson, conduit, dataDefault, fastLogger, hamlet, hjsmin
, httpConduit, monadControl, monadLogger, shakespeareCss
, shakespeareJs, shakespeareText, split, text, utf8String, waiExtra
, waiHandlerFastcgi, waiLogger, warp, yaml, yesod, yesodAuth
, yesodCore, yesodForm, yesodStatic, uuid
, libcgroup, fetchurl
}:

cabal.mkDerivation (self: {
  pname = "tobias-cgroup-manager";
  version = "0.0.1";
  src = fetchurl {
    url = https://s3.amazonaws.com/tobiaspersonal/tobias-cgroup-manager/tobias-cgroup-manager.tar.gz;
    md5 = "8470c68f5e4d21b5524a739711a50d20";
  };
  sha256 = "6a324992babca33cb62fc6bc1306d784";
  isLibrary = true;
  isExecutable = false;
  extraLibraries = [ libcgroup ];
  buildDepends = [
    aeson conduit dataDefault fastLogger hamlet hjsmin httpConduit
    monadControl monadLogger shakespeareCss shakespeareJs
    shakespeareText split text utf8String waiExtra waiHandlerFastcgi
    waiLogger warp yaml yesod yesodAuth yesodCore yesodForm yesodStatic uuid
  ];
  meta = {
    platforms = self.ghc.meta.platforms;
  };
})

