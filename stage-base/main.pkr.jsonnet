local semver = import 'semver.libsonnet';

// providers
local common = import 'common.libsonnet';
local hetzner = import 'hetzner.libsonnet';
local libvirt = import 'libvirt.libsonnet';

// configuration
local version = '3.13.5';
local mirror = 'alpine.global.ssl.fastly.net';

{
  local fetchURL = common.fetchURL(version, mirror),
  source: libvirt.source(fetchURL.iso) + hetzner.source(version),
  build: {
    sources: libvirt.sourcePath + hetzner.sourcePath,
    provisioner: hetzner.preInstallProvisioner(fetchURL.rootFS) + common.installProvisioner,
    'post-processor': libvirt.postProcessor,
  },
}
