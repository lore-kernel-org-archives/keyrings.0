From: Dave Young <dyoung@redhat.com>
Date: Fri, 08 Jun 2018 07:28:48 +0000
Subject: Re: [PATCH] certs: always use secondary keyring first if possible
Message-Id: <20180608072848.GA7773@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171118044711.GA7352@dhcp-128-65.nay.redhat.com>
 <20171214102513.GA2371@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20171214102513.GA2371@dhcp-128-65.nay.redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, mathew.j.martineau@linux.intel.com, Laura Abbott <labbott@redhat.com>, jwboyer@redhat.com

On 12/14/17 at 06:25pm, Dave Young wrote:
> On 11/18/17 at 12:47pm, Dave Young wrote:
> > Commit d3bfe84129f6 introduced secondary_trusted_keys keyring, current
> > users of verify_pkcs7_signature are below:
> > net/wireless/reg.c : uses its own trusted_keys
> > kernel/module_signing.c : pass NULL trusted_keys 
> > crypto/asymmetric_keys/verify_pefile.c : pass NULL trusted_keys
> > 
> > For both module and pefile verification, there is no reason to use builtin
> > keys only. Actually in Fedora kernel module signing code passes 1UL, but
> > kexec code does not pass 1UL for pefile verification thus we have below bug
> > https://bugzilla.redhat.com/show_bug.cgi?id70995
> > 
> > Drop the hard code 1UL checking so that pefile verification can use
> > secondary keyring as well.
> > 
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > ---
> >  certs/system_keyring.c |    2 --
> >  1 file changed, 2 deletions(-)
> > 
> > --- linux-x86.orig/certs/system_keyring.c
> > +++ linux-x86/certs/system_keyring.c
> > @@ -229,8 +229,6 @@ int verify_pkcs7_signature(const void *d
> >  		goto error;
> >  
> >  	if (!trusted_keys) {
> > -		trusted_keys = builtin_trusted_keys;
> > -	} else if (trusted_keys = (void *)1UL) {
> >  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
> >  		trusted_keys = secondary_trusted_keys;
> >  #else
> 
> Another ping.
> 
> If the (-1UL) is really needed, below file need update to use it
> But I think it is ugly..
> crypto/asymmetric_keys/verify_pefile.c

Ping again.  Can anyone response to this issue?

Let me describe more details about the problem:

In Fedora kernel there is a patch below which is not upstreamed:
https://src.fedoraproject.org/rpms/kernel/blob/master/f/Fix-for-module-sig-verification.patch

It has below changes:

---
diff --git a/kernel/module_signing.c b/kernel/module_signing.c
index 937c844..d3d6f95 100644
--- a/kernel/module_signing.c
+++ b/kernel/module_signing.c
@@ -81,6 +81,6 @@ int mod_verify_sig(const void *mod, unsigned long *_modlen)
 	}

 	return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
-				      NULL, VERIFYING_MODULE_SIGNATURE,
+				      (void *)1UL, VERIFYING_MODULE_SIGNATURE,
 				      NULL, NULL);
 }
---

Above change is needed because the verify_pkcs7_signature is doing
below:
---
        if (!trusted_keys) {
                trusted_keys = builtin_trusted_keys;
        } else if (trusted_keys = (void *)1UL) {
#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
                trusted_keys = secondary_trusted_keys;
#else
                trusted_keys = builtin_trusted_keys;
#endif
        }
---

The trusted_keys is an argument passed to verify_pkcs7_signature
function. We can see that users of this function must pass "-1UL"
as trusted_keys to use secondary keyring.  This "-1UL" is not
documented and it looks a hardcode api.   Besides of the module
signing code, actually as I mentioned in the patch log kexec/kdump
also need passing "-1UL" to use the secondary keyring.

But why do we need that hack?  If I understand it correctly
if use secondary then builtin can still be used, see commit log
of d3bfe84129f65e0af2450743ebdab33d161d01c9:
    If the secondary keyring is enabled, a link is created from that to
    .builtin_trusted_keys so that the the latter will automatically be searched
    too if the secondary keyring is searched.

So why not directly use secondary in case trusted_keys = NULL?

I'm not familar with the certs/keyring code, if I'm wrong please
correct me.

--
Thanks
Dave

