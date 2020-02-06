From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Thu, 06 Feb 2020 15:11:19 +0000
Subject: [PATCH 00/11] Manually convert  thermal, crypto and misc-devices to ReST
Message-Id: <cover.1581001737.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: Linux Media Mailing List <linux-media@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, "David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Javi Merino <javi.merino@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Howells <dhowells@redhat.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, keyrings@vger.kernel.org

Manually convert some files from thermal, crypto and misc-devices
to ReST format.

This patch is against linux-next 20200204 tag.

Mauro Carvalho Chehab (11):
  docs: thermal: convert cpu-idle-cooling.rst to ReST
  docs: crypto: convert asymmetric-keys.txt to ReST
  docs: crypto: convert api-intro.txt to ReST format
  docs: crypto: convert async-tx-api.txt to ReST format
  docs: crypto: descore-readme.txt: convert to ReST format
  docs: misc-devices/spear-pcie-gadget.txt: convert to ReST
  docs: misc-devices/pci-endpoint-test.txt: convert to ReST
  docs: misc-devices/pci-endpoint-test.txt: convert to ReST
  docs: misc-devices/c2port.txt: convert to ReST format
  docs: misc-devices/bh1770glc.txt: convert to ReST
  docs: misc-devices/apds990x.txt: convert to ReST format

 .../crypto/{api-intro.txt => api-intro.rst}   | 186 +++++++------
 ...symmetric-keys.txt => asymmetric-keys.rst} |  91 +++----
 .../{async-tx-api.txt => async-tx-api.rst}    | 253 +++++++++++-------
 ...{descore-readme.txt => descore-readme.rst} | 152 +++++++----
 Documentation/crypto/index.rst                |   5 +
 .../driver-api/thermal/cpu-idle-cooling.rst   |  18 +-
 Documentation/driver-api/thermal/index.rst    |   1 +
 .../{ad525x_dpot.txt => ad525x_dpot.rst}      |  24 +-
 .../{apds990x.txt => apds990x.rst}            |  31 ++-
 .../{bh1770glc.txt => bh1770glc.rst}          |  45 +++-
 .../misc-devices/{c2port.txt => c2port.rst}   |  58 ++--
 Documentation/misc-devices/index.rst          |   6 +
 .../misc-devices/pci-endpoint-test.rst        |  56 ++++
 .../misc-devices/pci-endpoint-test.txt        |  41 ---
 .../misc-devices/spear-pcie-gadget.rst        | 170 ++++++++++++
 .../misc-devices/spear-pcie-gadget.txt        | 130 ---------
 16 files changed, 747 insertions(+), 520 deletions(-)
 rename Documentation/crypto/{api-intro.txt => api-intro.rst} (70%)
 rename Documentation/crypto/{asymmetric-keys.txt => asymmetric-keys.rst} (91%)
 rename Documentation/crypto/{async-tx-api.txt => async-tx-api.rst} (55%)
 rename Documentation/crypto/{descore-readme.txt => descore-readme.rst} (81%)
 rename Documentation/misc-devices/{ad525x_dpot.txt => ad525x_dpot.rst} (85%)
 rename Documentation/misc-devices/{apds990x.txt => apds990x.rst} (86%)
 rename Documentation/misc-devices/{bh1770glc.txt => bh1770glc.rst} (83%)
 rename Documentation/misc-devices/{c2port.txt => c2port.rst} (59%)
 create mode 100644 Documentation/misc-devices/pci-endpoint-test.rst
 delete mode 100644 Documentation/misc-devices/pci-endpoint-test.txt
 create mode 100644 Documentation/misc-devices/spear-pcie-gadget.rst
 delete mode 100644 Documentation/misc-devices/spear-pcie-gadget.txt

-- 
2.24.1
