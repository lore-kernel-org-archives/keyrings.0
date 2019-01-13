From: Dave Young <dyoung@redhat.com>
Date: Sun, 13 Jan 2019 01:39:58 +0000
Subject: Re: [RFC PATCH 2/2] kexec, KEYS: Make use of platform keyring for signature verify
Message-Id: <20190113013958.GA14019@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190109164824.19708-1-kasong@redhat.com>
 <20190109164824.19708-3-kasong@redhat.com>
 <20190111134303.GA12760@dhcp-128-65.nay.redhat.com>
 <1547223220.19931.471.camel@linux.ibm.com>
In-Reply-To: <1547223220.19931.471.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org, dhowells@redhat.com, dwmw2@infradead.org, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com, linux-integrity@vger.kernel.org, kexec@lists.infradead.org

Hi,

On 01/11/19 at 11:13am, Mimi Zohar wrote:
> On Fri, 2019-01-11 at 21:43 +0800, Dave Young wrote:
> [snip]
>=20
> > Personally I would like to see platform key separated from integrity.
> > But for the kexec_file part I think it is good at least it works with
> > this fix.
> >=20
> > Acked-by: Dave Young <dyoung@redhat.com>
>=20
> The original "platform" keyring patches that Nayna posted multiple
> times were in the certs directory, but nobody commented/responded. =A0So
> she reworked the patches, moving them to the integrity directory and
> posted them (cc'ing the kexec mailing list). =A0It's a bit late to be
> asking to move it, isn't it?

Hmm, apologize for being late,  I did not get chance to have a look the
old series.  Since we have the needs now, it should be still fine

Maybe Kairui can check Nayna's old series, see if he can do something
again?

>=20
> Mimi
>=20

Thanks
Dave
