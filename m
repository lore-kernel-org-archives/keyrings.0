From: Eric Biggers <ebiggers3@gmail.com>
Date: Tue, 28 Nov 2017 19:06:52 +0000
Subject: Re: [PATCH] KEYS: add missing permission check for request_key() destination
Message-Id: <20171128190652.GC45321@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171120225830.96642-1-ebiggers3@gmail.com>
	<7849.1511863981@warthog.procyon.org.uk>
In-Reply-To: <7849.1511863981@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

On Tue, Nov 28, 2017 at 10:13:01AM +0000, David Howells wrote:
> Eric Biggers <ebiggers3@gmail.com> wrote:
> 
> > +		if (do_perm_check) {
> > +			ret = key_permission(make_key_ref(dest_keyring, 1),
> > +					     KEY_NEED_WRITE);
> 
> dest_keyring may be NULL at this point as alloc_uid() doesn't automatically
> create keyrings.
> 
> David

Argh, you're right.  I must have been confused by the calls to key_serial(),
key_put(), etc., but those all check for NULL.  I'll send a revised patch.

Eric
