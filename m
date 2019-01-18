From: Dave Young <dyoung@redhat.com>
Date: Fri, 18 Jan 2019 01:35:30 +0000
Subject: Re: [PATCH v3 0/2] let kexec_file_load use platform keyring to verify the kernel image
Message-Id: <20190118013530.GA2814@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190116101654.7288-1-kasong@redhat.com>
 <1547773684.4026.10.camel@linux.ibm.com>
In-Reply-To: <1547773684.4026.10.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org, dhowells@redhat.com, dwmw2@infradead.org, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com, linux-integrity@vger.kernel.org, kexec@lists.infradead.org

On 01/17/19 at 08:08pm, Mimi Zohar wrote:
> On Wed, 2019-01-16 at 18:16 +0800, Kairui Song wrote:
> > This patch series adds a .platform_trusted_keys in system_keyring as the
> > reference to .platform keyring in integrity subsystem, when platform
> > keyring is being initialized it will be updated. So other component cou=
ld
> > use this keyring as well.
>=20
> Remove "other component could use ...".
> >=20
> > This patch series also let kexec_file_load use platform keyring as fall
> > back if it failed to verify the image against secondary keyring, make it
> > possible to load kernel signed by third part key if third party key is
> > imported in the firmware.
>=20
> This is the only reason for these patches. =A0Please remove "also".
>=20
> >=20
> > After this patch kexec_file_load will be able to verify a signed PE
> > bzImage using keys in platform keyring.
> >=20
> > Tested in a VM with locally signed kernel with pesign and imported the
> > cert to EFI's MokList variable.
>=20
> It's taken so long for me to review/test this patch set due to a
> regression in sanity_check_segment_list(), introduced somewhere
> between 4.20 and 5.0.0-rc1. =A0The sgement overlap test - "if ((mend >
> pstart) && (mstart < pend))" - fails, returning a -EINVAL.
>=20
> Is anyone else seeing this?

Mimi, should be this issue?  I have sent a fix for that.
https://lore.kernel.org/lkml/20181228011247.GA9999@dhcp-128-65.nay.redhat.c=
om/

Thanks
Dave
