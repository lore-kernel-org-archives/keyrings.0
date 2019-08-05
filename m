From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 05 Aug 2019 14:28:15 +0000
Subject: Re: [PATCH] ima: Allow to import the blacklisted cert signed by secondary CA cert
Message-Id: <1565015295.11223.147.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <1564622625-112173-1-git-send-email-zhang.jia@linux.alibaba.com>
         <1564700229.11223.9.camel@linux.ibm.com>
         <d6a27436-3822-3dda-a3be-4e2dfbe04390@linux.alibaba.com>
In-Reply-To: <d6a27436-3822-3dda-a3be-4e2dfbe04390@linux.alibaba.com>
To: Jia Zhang <zhang.jia@linux.alibaba.com>, dhowells@redhat.com, dmitry.kasatkin@gmail.com
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, "Mark D. Baushke" <mdb@juniper.net>, Petko Manolov <petkan@mip-labs.com>

On Fri, 2019-08-02 at 09:42 +0800, Jia Zhang wrote:
> 
> On 2019/8/2 上午6:57, Mimi Zohar wrote:
> > Hi Jia,
> > 
> > On Thu, 2019-08-01 at 09:23 +0800, Jia Zhang wrote:
> >> Similar to .ima, the cert imported to .ima_blacklist is able to be
> >> authenticated by a secondary CA cert.
> >>
> >> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> > 
> > The IMA blacklist, which is defined as experimental for a reason, was
> > upstreamed prior to the system blacklist.  Any reason you're not using
> > the system blacklist?  Before making this sort of change, I'd like
> > some input from others.
> 
> In our trusted cloud service, the IMA private key is controlled by
> tenant for some reason. Some unprofessional operations made by tenant
> may lead to the leakage of IMA private key. So the need for importing
> the blacklisted is necessary，without system/kexec reboot, on the
> contrary, the system blacklist needs a kernel rebuild and system/kexec
> reboot, without runtime and fine-grained control.
> 
> The secondary CA cert has a similar story, but it is not controlled by
> tenant. It is always imported during system/kexec boot to serve
> importing IMA trusted cert and IMA blacklisted cert.

Before expanding the set of keys permitted to blacklist a key on the
IMA keyring, there needs to be a way of differentiating how keys may
be used.  The same certificate should not be allowed to be loaded onto
both the IMA and the IMA blacklist keyrings for obvious reasons.

The normal way of blacklisting a key is by using CRLs.  I'm not
recommending adding full CRL support in the kernel, but using the key
usage extension to differentiate who may sign a certificate being
black listed.  Please refer to section "4.2.1.3.  Key Usage", in
particular the cRLSign bit.

thanks,

Mimi
