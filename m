From: "Li, Juston" <juston.li@intel.com>
Date: Thu, 19 Jul 2018 06:09:35 +0000
Subject: RE: [PATCH v5 09/12] nfit/libnvdimm: add support for issue secure erase DSM to Intel nvdimm
Message-Id: <B89455A0D28AB940A83F8ADCAF0DF23E2DA206BA@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153186061802.27463.14539931103401173743.stgit@djiang5-desk3.ch.intel.com>
 <153186089522.27463.4537738384176593789.stgit@djiang5-desk3.ch.intel.com>
 <AT5PR8401MB11692A3B06A2BDB669DBEA9BAB530@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
 <f9873585-2f9a-6f15-0783-7f784b777ce4@intel.com>
 <AT5PR8401MB1169AAD6B37FAA0004A2D334AB520@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <AT5PR8401MB1169AAD6B37FAA0004A2D334AB520@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
To: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>
Cc: "dhowells@redhat.com" <dhowells@redhat.com>, "Schofield, Alison  <alison.schofield@intel.com>, keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "keescook@chromium.org" <keescook@chromium.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>

> -----Original Message-----
> From: Linux-nvdimm [mailto:linux-nvdimm-bounces@lists.01.org] On Behalf Of
> Elliott, Robert (Persistent Memory)
> Sent: Wednesday, July 18, 2018 6:43 PM
> To: Jiang, Dave <dave.jiang@intel.com>; Williams, Dan J
> <dan.j.williams@intel.com>
> Cc: dhowells@redhat.com; Schofield, Alison <alison.schofield@intel.com>;
> keyrings@vger.kernel.org; keescook@chromium.org; linux-
> nvdimm@lists.01.org
> Subject: RE: [PATCH v5 09/12] nfit/libnvdimm: add support for issue secure erase
> DSM to Intel nvdimm
> 
>
> Related topic: a flush is also necessary before sending the secure erase or unlock
> command.  Otherwise, there could be dirty write data that gets written by the
> concluding flush (overwriting the now-unlocked or just-erased data).  For unlock
> during boot, you might assume that no writes having occurred yet, but that isn't
> true for secure erase on demand.  Flushing before both commands is safest.
> 

I was wondering this too.

Is it handled by the fact the DIMM must be disabled to do a secure erase?
I'm assuming that means the namespace that the DIMM is a part of also must be
disabled first? Then no further writes can occur and provided that dirty write data is
flushed when the namespace is disabled, it should be safe to issue a secure erase.

Thanks
Juston
