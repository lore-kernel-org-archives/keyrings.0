From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 09 Jan 2019 14:07:36 +0000
Subject: Re: [RFC PATCH 1/1] KEYS, integrity: Link .platform keyring to .secondary_trusted_keys
Message-Id: <1547042856.19931.229.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20190108081247.2266-1-kasong@redhat.com>
         <20190108081247.2266-2-kasong@redhat.com>
         <1546960680.19931.114.camel@linux.ibm.com>
         <20190109013356.GA2610@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190109013356.GA2610@dhcp-128-65.nay.redhat.com>
To: Dave Young <dyoung@redhat.com>
Cc: Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org, dhowells@redhat.com, dwmw2@infradead.org, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com, linux-security-module <linux-security-module@vger.kernel.org>, linux-integrity <linux-integrity@vger.kernel.org>, kexec@lists.infradead.org

On Wed, 2019-01-09 at 09:33 +0800, Dave Young wrote:
> CC kexec list
> On 01/08/19 at 10:18am, Mimi Zohar wrote:
> > [Cc'ing the LSM and integrity mailing lists]
> > 
> > Repeating my comment on PATCH 0/1 here with the expanded set of
> > mailing lists.
> > 
> > The builtin and secondary keyrings have a signature change of trust
> > rooted in the signed kernel image.  Adding the pre-boot keys to the
> > secondary keyring breaks that signature chain of trust.
> > 
> > Please do NOT add the pre-boot "platform" keys to the secondary
> > keyring.
> 
> If we regard kexec as a bootloader, it sounds natural to use the
> platform key to verify the signature with kexec_file_load syscall.
> 
> It will be hard for user to manually sign a kernel and import the key
> then to reuse kexec_file_load.

This is really a generic topic, not limited to kexec, which should be
discussed.  Let's defer this discussion for now.

> 
> I think we do not care if platform key can be added to secondary or not,
> any suggestions how can kexec_file to use the platform key?

I assume the problem is accessing the keyring id.

Instead of defining a function to return the keyring id, as below,
define a function that sets a variable with the keyring id.
 platform_keyring_init() would call that function to set the variable.

Similar to builtin_trusted_keys and secondary_trusted_keys, define a
variable named platform_trusted_keys.

[snip]

> > > diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> > > index f45d6edecf99..397758d4f12d 100644
> > > --- a/security/integrity/digsig.c
> > > +++ b/security/integrity/digsig.c
> > > @@ -176,3 +176,10 @@ int __init integrity_load_cert(const unsigned int id, const char *source,
> > >  	pr_info("Loading X.509 certificate: %s\n", source);
> > >  	return integrity_add_key(id, data, len, perm);
> > >  }
> > > +
> > > +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> > > +struct key* __init integrity_get_platform_keyring(void)
> > > +{
> > > +	return keyring[INTEGRITY_KEYRING_PLATFORM];
> > > +}
> > > +#endif

Mimi
