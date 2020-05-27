From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 27 May 2020 19:47:05 +0000
Subject: Re: [RESEND] security/keys: remove possessor verify after key permission check
Message-Id: <cce1dc1bf68c72ad3229b4de4cf46e905d254424.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20200505091958.GD16980@willie-the-truck>
In-Reply-To: <20200505091958.GD16980@willie-the-truck>
To: keyrings@vger.kernel.org

On Mon, 2020-05-25 at 13:56 +0300, Alexey Krasikov wrote:
> 14.05.2020 12:46, Alexey Krasikov пишет:
> > > 07.05.2020, 10:24, "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>:
> > > 
> > >     Tried this:
> > > 
> > > 
> > >     $ KEYID=$(keyctl add user john smith @u)
> > >     $ keyctl setperm $KEYID 0x20000000
> > >     $ keyctl read $KEYID
> > >     keyctl_read_alloc: Permission denied
> > > 
> > >     You did not provide a full example like this so I have to assume 
> > > that
> > >     this is what you meant.
> > > 
> > >     /Jarkko
> > > 
> > > 
> > 
> > You've removed all the attributes except the reading.
> > Nothing can be done with the key if it can't be found.
> > Try this:
> > $ KEYID=$(keyctl add user john smith @u)
> > $ keyctl describe $KEYID
> > $ keyctl setperm $KEYID 0x3d000000
> > $ keyctl describe $KEYID
> > $ keyctl print $KEYID
> > /Alexey
> 
> ping

Please send a new version with a full example of the scenario that
you are referring. This thread became too messy to follow with the
HTML emails included (that do no reach vger).

/Jarkko
