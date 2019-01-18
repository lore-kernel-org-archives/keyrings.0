From: Dave Young <dyoung@redhat.com>
Date: Fri, 18 Jan 2019 12:37:45 +0000
Subject: Re: [PATCH v4 0/2] let kexec_file_load use platform keyring to verify the kernel image
Message-Id: <20190118123745.GA31072@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190118091733.29940-1-kasong@redhat.com>
 <1547812432.3982.55.camel@linux.ibm.com>
 <20190118123437.GA30929@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190118123437.GA30929@dhcp-128-65.nay.redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org, dhowells@redhat.com, dwmw2@infradead.org, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com, linux-integrity@vger.kernel.org, kexec@lists.infradead.org

On 01/18/19 at 08:34pm, Dave Young wrote:
> On 01/18/19 at 06:53am, Mimi Zohar wrote:
> > On Fri, 2019-01-18 at 17:17 +0800, Kairui Song wrote:
> > > This patch series adds a .platform_trusted_keys in system_keyring as =
the
> > > reference to .platform keyring in integrity subsystem, when platform
> > > keyring is being initialized it will be updated. So other component c=
ould
> > > use this keyring as well.
> >=20
> > Kairui, when people review patches, the comments could be specific,
> > but are normally generic. =A0My review included a couple of generic
> > suggestions - not to use "#ifdef" in C code (eg. is_enabled), use the
> > term "preboot" keys, and remove any references to "other components".
> >=20
> > After all the wording suggestions I've made, you are still saying, "So
> > other components could use this keyring as well".=A0=A0Really?! =A0How =
the
> > platform keyring will be used in the future, is up to you and others
> > to convince Linus. =A0At least for now, please limit its usage to
> > verifying the PE signed kernel image. =A0If this patch set needs to be
> > reposted, please remove all references to "other components".
> >=20
> > Dave/David, are you ok with Kairui's usage of "#ifdef's"? =A0Dave, you
> > Acked the original post. =A0Can I include it? =A0Can we get some
> > additional Ack's on these patches?
>=20
> It is better to update patch to use IS_ENABLED in patch 1/2 as well.

Hmm, not only for patch 1/2, patch 2/2 also need an update

> Other than that, for kexec part I'm fine with an ack.
> =20
> Thanks
> Dave
