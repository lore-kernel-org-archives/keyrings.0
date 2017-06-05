From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 05 Jun 2017 22:03:10 +0000
Subject: Re: [PATCH v2] KEYS: Convert KEYCTL_DH_COMPUTE to use the crypto KPP API
Message-Id: <20170605220310.GC87699@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <1638.1496419102@warthog.procyon.org.uk>
In-Reply-To: <1638.1496419102@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org

Hi Stephan,

On Mon, Jun 05, 2017 at 11:51:32PM +0200, Stephan M=FCller wrote:
> Am Montag, 5. Juni 2017, 05:41:32 CEST schrieb Eric Biggers:
>=20
> Hi Eric,
> >=20
> > Also, Stephan, what is the purpose of the "__spare" field in
> > keyctl_kdf_params? How is it ever supposed to be used for anything if t=
he
> > kernel doesn't even validate that it contains 0's?  Some flag hacked in=
to
> > the 'otherinfolen' field...?
>=20
> The idea in the very first patch set was the presence of a "flags" field.=
 We=20
> have a proliferation of system calls in the last few years which just add=
 a=20
> "flags" parameter compared to an identical older system call.
>=20
> To prevent falling into this trap, I wanted to have a flags field. The co=
re=20
> reason is that there are multiple options allowed and possible how to der=
ive a=20
> key. The current approach is the easiest and smallest one, i.e. using the=
=20
> SP800-108 counter KDF. Other KDFs are possible too. To allow such opennes=
s, we=20
> decided to leave some room.
>=20
> See https://patchwork.kernel.org/patch/9224837/ and search for __spare[8]=
 in=20
> the answer from Mat.
>=20

Well, regardless of what it's reserved *for* (if anything), this is *not* t=
he
correct way to do a reserved field.  The API needs to verify that it has va=
lue 0
and return -EINVAL otherwise, i.e.

	if (memchr_inv(kdfcopy->__spare, 0, sizeof(kdfcopy->__spare)))
		return -EINVAL;

It can't simply be ignored, otherwise users will have no way to know whethe=
r any
new fields are recognized or not.  Also if there is no validation, users wi=
ll
screw up and pass in a nonzero value (perhaps through leaving it uninitiali=
zed)
before it's un-reserved, which will then break as soon as the space is actu=
ally
used for something.

Eric
