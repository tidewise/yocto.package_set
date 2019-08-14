# Autoproj package set to work with Yocto and Mender

This package set provides package definitions to setup and work with a
Yocto/Mender environment alongside with an Autoproj project

It provides definitions for base layers, allowing them to be imported using
autoproj, as well as a `yocto_package` handler.

A `yocto_package` is a package with a `conf/` folder that may include
`local.conf` and `bblayers.conf` files. These files are copied into the build
folder on 'build'. The integration does **not** run bitbake, as it is a MASSIVE
operation on first checkout.

The `bblayers.conf` file is processed by the Autoproj handler to replace
`$(locate:PACKAGE_NAME)` by the source directory of the package name. This is
meant to be used in the layer list in `bblayers.conf` to have them resolved to
their full paths.

Finally, the package set provides the `autoproj-yocto` script that allows you to
run yocto commands (such as bitbake) within the context of a Yocto package, with
the proper environment setup. For instance, one would run

~~~
autoproj-yocto . bitbake core-image-base
~~~

from within the yocto configuration package being worked on. This allows working
with multiple Yocto configurations in parallel relatively easily.

The Yocto build dir is set to be the package build dir. In addition, we use the
following conventions:

- layers are installed in `tools/yocto/`, using the same package name (e.g.
  meta-blabla is tools/yocto/meta-blabla
- yocto configuration packages are in `robots/`

## License

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
                        Version 2, December 2004 

     Copyright (C) 2019 TideWise

     Everyone is permitted to copy and distribute verbatim or modified 
     copies of this license document, and changing it is allowed as long 
     as the name is changed. 

                DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
       TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION 

      0. You just DO WHAT THE FUCK YOU WANT TO.

