From: Eric Biggers <ebiggers@kernel.org>
Date: Thu, 07 Feb 2019 23:36:14 +0000
Subject: Re: [PATCH] KEYS: reuse keyring_index_key::desc_len in lookup_user_key()
Message-Id: <20190207233613.GE125156@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

On Thu, Jan 10, 2019 at 12:28:38PM -0800, Eric Biggers wrote:
> On Fri, Nov 02, 2018 at 07:10:49PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > When lookup_user_key() checks whether the key is possessed, it should
> > use the key's existing index_key including the 'desc_len' field, rather
> > than recomputing the 'desc_len'.  This shouldn't cause any observable
> > behavior change; this way is just simpler and faster.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  security/keys/process_keys.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
> > index d5b25e535d3a5..3bea09e7176d7 100644
> > --- a/security/keys/process_keys.c
> > +++ b/security/keys/process_keys.c
> > @@ -688,9 +688,7 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
> >  		key_ref = make_key_ref(key, 0);
> >  
> >  		/* check to see if we possess the key */
> > -		ctx.index_key.type		= key->type;
> > -		ctx.index_key.description	= key->description;
> > -		ctx.index_key.desc_len		= strlen(key->description);
> > +		ctx.index_key			= key->index_key;
> >  		ctx.match_data.raw_data		= key;
> >  		kdebug("check possessed");
> >  		skey_ref = search_process_keyrings(&ctx);
> > -- 
> > 2.19.1
> > 
> 
> Ping.

Ping.  David, are you planning to apply this?

- Eric
