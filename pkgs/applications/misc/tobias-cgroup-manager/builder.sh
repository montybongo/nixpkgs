source $stdenv/setup

echo "Startup"
echo $out
mkdir $out
mkdir $out/bin
mkdir $out/bin/tobias-cgroup-manager-bin
#mkdir $out/tobias-cgroup-manager
tar xvf $src -C $out/bin/tobias-cgroup-manager-bin