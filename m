From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Wed, 17 Oct 2018 15:28:41 +0000
Subject: Re: [PATCH] support other engines for module signing
Message-Id: <1539790121.3769.27.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <alpine.LFD.2.21.1810171142300.20697@hatman>
In-Reply-To: <alpine.LFD.2.21.1810171142300.20697@hatman>
To: keyrings@vger.kernel.org

On Wed, 2018-10-17 at 08:18 -0700, David Woodhouse wrote:
> On Wed, 2018-10-17 at 08:10 -0700, James Bottomley wrote:
> > On Wed, 2018-10-17 at 08:05 -0700, David Woodhouse wrote:
> > > On Wed, 2018-10-17 at 07:43 -0700, James Bottomley wrote:
> > > > On Wed, 2018-10-17 at 15:40 +0100, David Howells wrote:
> > > > > James Bottomley <James.Bottomley@HansenPartnership.com>
> > > > > wrote:
> > > > > 
> > > > > > > Allow sign-file to use any available OpenSSL engine, not
> > > > > > > limited
> > > > > > > to PKCS-11 by using "enginename:keyname" syntax.  We have
> > > > > > > to
> > > > > > > do a
> > > > > > > special case for pkcs11 key name passing.
> > > > > > 
> > > > > > There's actually already a proposal for this which David
> > > > > > (Howells)
> > > > > > has
> > > > > > been ignoring:
> > > > > 
> > > > > Not so much ignoring as it just keeps getting buried.
> > > > 
> > > > Understood.  What I really need is my patch testing by someone
> > > > at
> > > > Red
> > > > Hat: the pkcs11 token you use looks highly non-standard so
> > > > someone
> > > > needs to check that adding generic engine support doesn't break
> > > > it.
> > > 
> > > Que?
> > > 
> > > Which PKCS#11 token are you talking about? Or do you mean the
> > > PKCS#11
> > > engine, which is the normal one from 
> > > https://github.com/OpenSC/libp11
> > > 
> > > I think it does support using the UI for callbacks. Your trick of
> > > passing through to pem_pw_cb should probably work fine, as long
> > > as there's only ever one password. It should be trivial to test
> > > using SoftHSM or any other soft token, even if you have no actual
> > > hardware-based PKCS#11 tokens.
> > 
> > It didn't look like a normal one.  In fact it doesn't use UI
> > callbacks at all: it passes the key password in with an engine
> > command.  That's why I left it specifically cased out in the
> > file.  Now if it does actually work normally, the special casing
> > can be removed.
> 
> It looks just like yours. It uses the UI callbacks, but you can
> bypass those by providing the password in advance with an ENGINE_ctrl
> if you want.

Are we talking about the same thing?  This is the current RH code:

		ENGINE *e;

		e = ENGINE_by_id("pkcs11");
		ERR(!e, "Load PKCS#11 ENGINE");
		if (ENGINE_init(e))
			ERR_clear_error();
		else
			ERR(1, "ENGINE_init");
		if (key_pass)
			ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0),
			    "Set PKCS#11 PIN");
		private_key = ENGINE_load_private_key(e, private_key_name,
						      NULL, NULL);
		ERR(!private_key, "%s", private_key_name);

It uses an engine control command to load the key password not a UI. 
Now if it will work with a UI, I can fold the cases.  Can someone tell
me if it does work with a UI?

> > No, the requirement seemed to be to add the engine to the openssl
> > config file.  There's no reason why an additional command parameter
> > can't be added, though.
> 
> But ENGINE_load_private_key() needs to be used with a specific
> ENGINE, doesn't it?

Actually no.  One engine can't load another engine's key (or doesn't
understand another engine's URI) so you can iterate over all engines
until you get one that succeeds.  That was the principle of the
original "integrate engines into the main load paths" patch years ago. 
Even the engine lockout machinery isn't invoked until you actually have
a loaded key, so the path is safe.

To add a command specifier, you try that engine (and only that engine)
but the fallback behaviour would be to try them all because that's how
the token works today.  I told Mark I'd be happy to code this.

>  Unless we're actually using the new STORE API, then referencing the
> privkey by a name that the engine has registered with the STORE code
> — either a URI scheme, or an ASN.1 parser that gets invoked by the
> file_loader.

Tag recognition is useful but not required.  The only requirement is
that the engine be able to recognise something that's not its own key
an fail without any other implications.

James
