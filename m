From: David Howells <dhowells@redhat.com>
Date: Mon, 05 Jun 2017 10:03:32 +0000
Subject: Re: [PATCH v2] KEYS: Convert KEYCTL_DH_COMPUTE to use the crypto KPP API
Message-Id: <30301.1496657012@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <2210575.YAdSgJatlP@tauon.chronox.de>
	<20170511003557.3467-1-mathew.j.martineau@linux.intel.com>
	<1638.1496419102@warthog.procyon.org.uk>
In-Reply-To: <2210575.YAdSgJatlP@tauon.chronox.de>
To: linux-security-module@vger.kernel.org

Stephan M=C3=BCller <smueller@chronox.de> wrote:

> > Note that I haven't included Eric's DH patch that was obsoleted by Step=
han's
> > patch that was obsoleted by this one.
>=20
> Eric's patches 1, 2, 4, and 5 should be pulled as they are unrelated to a=
ny=20
> other patch. Eric's patch 3 should be disregarded, my patch in response t=
o=20
> Eric's patch 3 should be disregarded, and this patch from Mat should be u=
sed.

Indeed.  But Mat's patch doesn't apply.

David
