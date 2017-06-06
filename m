From: Mat Martineau <mathew.j.martineau@linux.intel.com>
Date: Tue, 06 Jun 2017 00:33:04 +0000
Subject: Re: [PATCH v2] KEYS: Convert KEYCTL_DH_COMPUTE to use the crypto KPP API
Message-Id: <alpine.OSX.2.21.1706051725150.7532@mjmartin-mac01.sea.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170511003557.3467-1-mathew.j.martineau@linux.intel.com>
	<1638.1496419102@warthog.procyon.org.uk>
In-Reply-To: <1638.1496419102@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org


Hi David -

On Fri, 2 Jun 2017, David Howells wrote:

> Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
>
>> The initial Diffie-Hellman computation made direct use of the MPI
>> library because the crypto module did not support DH at the time. Now
>> that KPP is implemented, KEYCTL_DH_COMPUTE should use it to get rid of
>> duplicate code and leverage possible hardware acceleration.
>
> This doesn't apply to linus/master.

It was on top of keys-next, for what it's worth.

> I've pushed the keyrings fix patches I
> have, including a bunch from Eric Biggers that fix DH stuff, to:
>
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
>
> branch:
>
> 	keys-fixes

I'll post a v3 that applies to keys-fixes right after I send this email.

>
> though I think there may be a couple of bugs in on of Eric's patches where
> he's assumed that he can do:
>
> 	memzero_explicit(NULL, 0);
>
> I'm not sure whether it's permissible to assume that memset(NULL, 0, 0) is
> guaranteed to work correctly.

I'm still working on unit test coverage to confirm correct behavior of KDF 
when the DH shared secret has leading zeros. Stephan, have you found any 
such tests (last time I asked you were still looking)? If I see 
inconsistent results when I make up a vector (choosing inputs that result 
in a 0x01 shared secret), I'm not sure if the old or new answer is 
correct.

> Note that I haven't included Eric's DH patch that was obsoleted by Stephan's
> patch that was obsoleted by this one.

Thanks,

--
Mat Martineau
Intel OTC
