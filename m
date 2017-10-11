From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Oct 2017 13:53:31 +0000
Subject: Re: [LTP] [PATCH 4/4] syscalls/add_key03: new test for forging user keyrings
Message-Id: <20171011135330.GD15968@rei>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171011134748.GC15968@rei>
In-Reply-To: <20171011134748.GC15968@rei>
To: keyrings@vger.kernel.org

Hi!
> > +static void do_test(void)
> > +{
> > +	int i;
> > +
> > +	/*
> > +	 * Try with multiple user IDs before reporting success.  By chance, some
> > +	 * users may already have an existing user keyring; the bug will not be
> > +	 * reproducible for them.
> > +	 */
> > +	for (i = 0; i < 10; i++) {
> > +		char description[32];
> > +		uid_t uid;
> > +		key_serial_t fake_user_keyring;
> > +		key_serial_t fake_user_session_keyring;
> > +
> > +		uid = rand();
> > +		if (uid = 0)
> > +			continue;
> 
> We have testcases that look for unused uid with this loop:
> 
> 	for (i = 1; i < 1000; i++) {
> 		if (!getpwuid(i))
> 			return i;
> 	}
> 
> What about using this instead of doing 10 random tries?

Or even better try to get the keyring as an user and proceed with the
test if there is none?

-- 
Cyril Hrubis
chrubis@suse.cz
