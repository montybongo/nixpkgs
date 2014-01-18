nixpkgs
=======

Nix Packages collection

This fork of the nix packages collection includes a package for the tobias-cgroup-manager.

This can be installed on nixos by: (You can grab a nixos AMI reference from: https://github.com/NixOS/nixops/blob/master/nix/ec2-amis.nix)

1. Adding the following configuration in  /etc/nixos/configuration.nix

```
  services.httpd.enable = true;
  services.httpd.adminAddr = "tobias@example.org";
  services.httpd.documentRoot = "/webroot";
  services.httpd.extraModules = [
    { name="fastcgi";
      path="${pkgs.mod_fastcgi}/modules/mod_fastcgi.so"; }
  ];
  services.httpd.extraConfig = 
  ''
    LogLevel debug
    AllowEncodedSlashes NoDecode
    ScriptAlias /tobias-cgroup-manager/ /wwwroot/fcgi-bin/tobias-cgroup-manager.fcgi/
    FastCgiIpcDir /tmp/
    FastCgiServer /wwwroot/fcgi-bin/tobias-cgroup-manager.fcgi -initial-env PATH=/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin -initial-env YESOD_ENVIRONMENT=Production
    <Directory /wwwroot/fcgi-bin/>
      Options Indexes FollowSymLinks
      AllowOverride None
      Order allow,deny
      Allow from all
      Options +ExecCGI
    </Directory>
    AddHandler fastcgi-script .fcgi
  ''; 
  environment.systemPackages = [pkgs.mod_fastcgi];

```

Also make sure you reference pkgs at the top of your configuration file:
{ config, pkgs, modulesPath, ...}:


2. Install mod_fastcgi and libcgroup

```
nix-env -iA nixos.pkgs.mod_fastcgi && nix-env -iA nixos.pkgs.libcgroup
```

3. Install Git

```
nix-env -iA nixos.pkgs.git
```

4. Clone the montybongo fork of the nixpks repo and checkout the tobias-cgroup-manager branch

```
git clone https://github.com/montybongo/nixpkgs.git
git checkout tobias-cgroup-manager
```

5. Install the tobias-cgroup-manager package

```
cd nixpkgs
nix-env -f . -iA tobias-cgroup-manager
```

6. Create a symlink to the tobias-cgroup-manager binary, this is so we don't have to have our whole bin exposed by Apache

```
mkdir /wwwroot/fcgi-bin/ -p
ln -s /root/.nix-profile/bin/tobias-cgroup-manager /wwwroot/fcgi-bin/tobias-cgroup-manager.fcgi
```   

7. We need to supply some sensible default configuration files in a config folder next to our symlink. We also need to specify the approot where the application will be hosted. The application also requires a folder named static to store any static files we may add at a later point.

```
cd /wwwroot/fcgi-bin/
curl -o config.tar.gz https://s3.amazonaws.com/tobiaspersonal/tobias-cgroup-manager/config.tar.gz
tar -zxvf config.tar.gz 
nano config/settings.yml and change the approot to the base url where you will be hosting the application
chmod a+w /wwwroot/fcgi-bin/config
```

8. Rebuild our nix configuration

```
nixos-rebuild switch
```

9. All going well you should now be able to visit the manager at http://yoururl/tobias-cgroup-manager/list-available-cgroups/

For instructions on using the library visit https://s3.amazonaws.com/tobiaspersonal/tobias-cgroup-manager/Handler-CGroupManager.html

For the source code of the library visit https://github.com/montybongo/tobias-cgroup-manager

If it does not work as planned check /var/log/httpd/error_log
