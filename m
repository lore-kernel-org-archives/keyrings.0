From: Dave Jiang <dave.jiang@intel.com>
Date: Fri, 12 Oct 2018 20:45:06 +0000
Subject: Re: [PATCH 2/2] conf: add upcall line for nvdimm in request-key.conf
Message-Id: <d494c206-86e7-3d9e-f6c2-905ea5008d10@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153936769332.53805.5782268917140745309.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153936769332.53805.5782268917140745309.stgit@djiang5-desk3.ch.intel.com>
To: keyrings@vger.kernel.org



On 10/12/2018 01:37 PM, David Howells wrote:
> You should take a look at this patch:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git/commit/?h=next&id_2f3c34b0b23e5d2ea4564ac990827c47999992

Ah that's great! Do you know when this will be released? Would also be
interested to know when Fedora will pick up this release.

> 
> on the keyutils next branch.  You should add a file into:
> 
> 	/etc/request-key.d/
> 
> with this line:
> 
> 	+create  logon   nvdimm*         *               /usr/sbin/nvdimm-upcall %k
> 
> in it.  Do you actually want to say "nvdimm:*", btw?

Yes. Good catch. I'll update that and also have ndctl package to install
/etc/request-key.d/nvdimm.conf with that instead.

Thanks.

> 
> David
> 
