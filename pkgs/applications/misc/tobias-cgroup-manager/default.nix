{stdenv, fetchurl, perl}:

stdenv.mkDerivation {
  name = "tobias-cgroup-manager-0.1";
  builder = ./builder.sh;
  src = fetchurl {
    url = https://s3.amazonaws.com/tobiaspersonal/tobias-cgroup-manager.tar;
    md5 = "001c099edc708c0021303e90fb25f9a0";
  };
  inherit perl;

  meta = {
    description = "A tool to help with cgroup management";
  };
}
