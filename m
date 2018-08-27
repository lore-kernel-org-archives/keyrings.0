From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 27 Aug 2018 08:25:01 +0000
Subject: Re: [PATCH 08/23] TPMLIB: Break TPM bits out of security/keys/trusted.c
Message-Id: <298a03a72bdded62290ce2db3a7a5219ccc5d8d2.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180824084930.GA10266@linux.intel.com>
         <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
         <153486706322.13066.3105842100625841410.stgit@warthog.procyon.org.uk>
         <20180824075227.GG3584@linux.intel.com>
         <25340.1535103190@warthog.procyon.org.uk>
In-Reply-To: <25340.1535103190@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: denkenz@gmail.com, jejb@linux.vnet.ibm.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, tpmdd-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org

On Fri, 2018-08-24 at 10:33 +0100, David Howells wrote:
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > I could rebase them and make a patch set out of them when I have time.
> 
> Thanks.  I'm not going to do anything further with this until after the merge
> window anyway.
> 
> And thanks for taking the time to look through the patches.  I just dumped the
> entire patchset on you rather than weeding out the duplicate/obsolete patches
> as I don't have time just now to port them to linus/master.

Are you coming to Edinburgh in late Oct? Could discuss there about TPM
and keyring "intersections" (not only this patch set but also trusted
keys etc.).

> David

/Jarkko
