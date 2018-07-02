From: Dave Jiang <dave.jiang@intel.com>
Date: Mon, 02 Jul 2018 23:39:07 +0000
Subject: [PATCH 00/11] Adding security support for nvdimm
Message-Id: <153057423804.38125.15912575101400055843.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: dan.j.williams@intel.com
Cc: dhowells@redhat.com, alison.schofield@intel.com, keyrings@vger.kernel.org, keescook@chromium.org, linux-nvdimm@lists.01.org

The following series implements security support for nvdimm. Mostly adding
new security DSM support from the Intel NVDIMM DSM spec v1.7, but also
adding generic support libnvdimm for other vendors. The most important
security features are unlocking locked nvdimms, and updating/setting security
passphrase to nvdimms.

Security folks, thanks in advance for taking a look at my key management
implementation and making sure that I'm doing something sane. Mainly you'll
want to review patches 2, 4, and 5 as most relevant ones that need scrutiny.

---

Dave Jiang (11):
      nfit: adding support for Intel DSM 1.7 commands
      libnvdimm: create keyring to store security keys
      nfit/libnvdimm: store dimm id as a member to struct nvdimm
      nfit/libnvdimm: add unlock of nvdimm support for Intel DIMMs
      nfit/libnvdimm: add set passphrase support for Intel nvdimms
      nfit/libnvdimm: add disable passphrase support to Intel nvdimm.
      nfit/libnvdimm: add freeze security support to Intel nvdimm
      nfit/libnvdimm: add support for issue secure erase DSM to Intel nvdimm
      nfit_test: adding context to dimm_dev for nfit_test
      nfit_test: adding test support for Intel nvdimm security DSMs
      libnvdimm: adding documentation for nvdimm security support


 Documentation/nvdimm/security    |   70 ++++++++
 drivers/acpi/nfit/Makefile       |    2 
 drivers/acpi/nfit/core.c         |   61 +++++--
 drivers/acpi/nfit/intel.c        |  348 ++++++++++++++++++++++++++++++++++++++
 drivers/acpi/nfit/intel.h        |  104 +++++++++++
 drivers/acpi/nfit/nfit.h         |   24 ---
 drivers/nvdimm/bus.c             |    2 
 drivers/nvdimm/dimm.c            |   97 +++++++++++
 drivers/nvdimm/dimm_devs.c       |  332 ++++++++++++++++++++++++++++++++++++
 drivers/nvdimm/nd-core.h         |    4 
 drivers/nvdimm/nd.h              |    2 
 include/linux/libnvdimm.h        |   35 ++++
 tools/testing/nvdimm/Kbuild      |    1 
 tools/testing/nvdimm/test/nfit.c |  226 +++++++++++++++++++++++--
 14 files changed, 1254 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/nvdimm/security
 create mode 100644 drivers/acpi/nfit/intel.c
 create mode 100644 drivers/acpi/nfit/intel.h

--
