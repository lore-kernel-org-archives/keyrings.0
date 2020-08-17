From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 17 Aug 2020 21:17:37 +0000
Subject: Re: [PATCH] keys: Do not check the retval of commit_creds in join_session_keyring
Message-Id: <20200817211737.GC44714@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <044b34c4388405e995e38fb57fc120361bf962db.1568124150.git.suse-tux@gmx.de>
In-Reply-To: <044b34c4388405e995e38fb57fc120361bf962db.1568124150.git.suse-tux@gmx.de>
To: keyrings@vger.kernel.org

On Tue, Jul 28, 2020 at 01:06:35PM +0200, Marcus H=FCwe wrote:
> On 2020-06-17 04:46:24 +0300, Jarkko Sakkinen wrote:
> > On Fri, Jun 12, 2020 at 01:25:33PM +0200, Marcus Huewe wrote:
> > > Do not check the return value of the commit_creds call in
> > > join_session_keyring in order to make the code more concise.
> > > Since commit_creds always returns 0, the if-statement is not needed
> > > and the session keyring's serial can be directly assigned to the
> > > "ret" variable.
> > >
> > > Signed-off-by: Marcus Huewe <suse-tux@gmx.de>
> >
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >
> > David, can you pick this up to your tree (give that a generic
> > keyring change)?
> >
> Just a gentle ping - any news on this?:)
>=20
> (I'm perfectly fine if you don't want to take it... (since it is
> just a minor cleanup and no bugfix))
>=20
>=20
> Marcus

I just came from two weeks of vacation and one week of network
connectivity issues (could not connect to the company VPN).

I still think that David should at least ack this.

/Jarkko
