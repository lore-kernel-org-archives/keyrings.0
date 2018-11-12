From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 12 Nov 2018 18:49:46 +0000
Subject: Re: [PATCH 02/11] libnvdimm/security: change clear text nvdimm keys to encrypted keys
Message-Id: <1542048586.3769.120.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <154180093865.70506.6858789591063128903.stgit@djiang5-desk3.ch.intel.com>
 <154180163666.70506.8805433934495072699.stgit@djiang5-desk3.ch.intel.com>
 <1541957268.3734.53.camel@linux.ibm.com>
 <CAPcyv4jMPDap8L6jTo9NGnrJGCjUY_BvSBuPge8NL4QS2Ku0CQ@mail.gmail.com>
 <1541966975.3734.78.camel@linux.ibm.com>
 <bf917ee9-1795-9c10-ecec-28c7d5d68345@intel.com>
In-Reply-To: <bf917ee9-1795-9c10-ecec-28c7d5d68345@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: keyrings@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>

On Mon, 2018-11-12 at 08:42 -0700, Dave Jiang wrote:

> How does one generate new encrypted keys with the system masterkey 
> removed from the keyring?

I don't think you can.

Mimi
