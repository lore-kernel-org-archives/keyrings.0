From: Dave Young <dyoung@redhat.com>
Date: Tue, 15 Jan 2019 02:42:43 +0000
Subject: Re: [RFC PATCH 2/2] kexec, KEYS: Make use of platform keyring for signature verify
Message-Id: <20190115024243.GA9199@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190109164824.19708-1-kasong@redhat.com>
 <20190109164824.19708-3-kasong@redhat.com>
 <20190111134303.GA12760@dhcp-128-65.nay.redhat.com>
 <1547223220.19931.471.camel@linux.ibm.com>
 <20190113013958.GA14019@dhcp-128-65.nay.redhat.com>
 <1547482251.4156.127.camel@linux.ibm.com>
In-Reply-To: <1547482251.4156.127.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org, dhowells@redhat.com, dwmw2@infradead.org, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com, linux-integrity@vger.kernel.org, kexec@lists.infradead.org

On 01/14/19 at 11:10am, Mimi Zohar wrote:
> On Sun, 2019-01-13 at 09:39 +0800, Dave Young wrote:
> > Hi,
> >=20
> > On 01/11/19 at 11:13am, Mimi Zohar wrote:
> > > On Fri, 2019-01-11 at 21:43 +0800, Dave Young wrote:
> > > [snip]
> > >=20
> > > > Personally I would like to see platform key separated from integrit=
y.
> > > > But for the kexec_file part I think it is good at least it works wi=
th
> > > > this fix.
> > > >=20
> > > > Acked-by: Dave Young <dyoung@redhat.com>
> > >=20
> > > The original "platform" keyring patches that Nayna posted multiple
> > > times were in the certs directory, but nobody commented/responded. =
=A0So
> > > she reworked the patches, moving them to the integrity directory and
> > > posted them (cc'ing the kexec mailing list). =A0It's a bit late to be
> > > asking to move it, isn't it?
> >=20
> > Hmm, apologize for being late,  I did not get chance to have a look the
> > old series.  Since we have the needs now, it should be still fine
> >=20
> > Maybe Kairui can check Nayna's old series, see if he can do something
> > again?
>=20
> Whether the platform keyring is defined in certs/ or in integrity/ the
> keyring id needs to be accessible to the other, without making the
> keyring id global. =A0Moving where the platform keyring is defined is
> not the problem.

Agreed, but just feel kexec depends on IMA sounds not good.

>=20
> Commit a210fd32a46b ("kexec: add call to LSM hook in original
> kexec_load syscall") introduced a new LSM hook. =A0Assuming
> CONFIG_KEXEC_VERIFY_SIG is enabled, with commit b5ca117365d9 ("ima:
> prevent kexec_load syscall based on runtime secureboot flag") we can
> now block the kexec_load syscall. =A0Without being able to block the
> kexec_load syscall, verifying the kexec image signature via the
> kexec_file_load syscall is kind of pointless.
>=20
> Unless you're planning on writing an LSM to prevent the kexec_load
> syscall, I assume you'll want to enable integrity anyway.

User can disable kexec_load in kernel config, and only allow
kexec_file_load.  But yes, this can be improved separately in case no
IMA enabled.

For the time being we can leave with it and fix like this series do.

>=20
> Mimi
>=20

Thanks
Dave
