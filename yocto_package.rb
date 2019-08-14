class YoctoPackage < Autobuild::Package
    attr_accessor :builddir

    def src_path(*args)
        File.join(srcdir, *args)
    end

    def build_path(*args)
        File.join(builddir, *args)
    end

    def process_file(path)
        File.readlines(path).map do |line|
            line.gsub(/\$\(locate:([^\)]+)\)/) do
                package_name = $1
                puts "PKG: #{package_name}"
                ws.manifest.find_autobuild_package(package_name).srcdir
            end
        end.join
    end

    def prepare
        super

        %w[local.conf bblayers.conf].each do |conf|
            src = src_path('conf', conf)
            dst = build_path('conf', conf)
            if File.file?(src)
                file dst => src do
                    content = process_file(src)
                    FileUtils.mkdir_p File.join(builddir, 'conf')
                    File.open(dst, 'w') { |io| io.write(content) }
                end
                file installstamp => dst
            end
        end
    end
        
    def install
        super
    end
end

def Autobuild.yocto(name)
    YoctoPackage.new(name)
end

def yocto_package(name, workspace: Autoproj.workspace, &block)
    package_common(:yocto, name, workspace: workspace, &block)
end

