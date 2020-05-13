From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 13 May 2020 02:33:11 +0000
Subject: Re: [PATCH v3] security/keys: rewrite big_key crypto to use library interface
Message-Id: <CAHmME9r4Pag4ML-GVaKHFTZ_T_unhWg1LxVuEk6wKp006ZAFXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHmME9oXiTmVuOYmG=K3ijWK+zP2yB9a2CFjbLx_5fkDiH30Tg@mail.gmail.com>
 <20200511215101.302530-1-Jason@zx2c4.com> <2620780.1589289425@warthog.procyon.org.uk>
 <CAHmME9q-TxHo5o63rxHzKwV_kWV9u+MoxBQM5Yz3hODGCj7RhQ@mail.gmail.com> <2858489.1589321003@warthog.procyon.org.uk>
In-Reply-To: <2858489.1589321003@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, kernel-hardening@lists.openwall.com, Eric Biggers <ebiggers@google.com>

On Tue, May 12, 2020 at 4:03 PM David Howells <dhowells@redhat.com> wrote:
>
> Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> > So long as that ->update function:
> > 1. Deletes the old on-disk data.
> > 2. Deletes the old key from the inode.
> > 3. Generates a new key using get_random_bytes.
> > 4. Stores that new key in the inode.
> > 5. Encrypts the updated data afresh with the new key.
> > 6. Puts the updated data onto disk,
> >
> > then this is fine with me, and feel free to have my Acked-by if you
> > want. But if it doesn't do that -- i.e. if it tries to reuse the old
> > key or similar -- then this isn't fine. But it sounds like from what
> > you've described that things are actually fine, in which case, I guess
> > it makes sense to apply your patch ontop of mine and commit these.
>
> Yep.  It calls big_key_destroy(), which clears away the old stuff just as when
> a key is being destroyed, then generic_key_instantiate() just as when a key is
> being set up.
>
> The key ID and the key metadata (ownership, perms, expiry) are maintained, but
> the payload is just completely replaced.

Okay, in that case, take my:

    Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>

And then perhaps you can take both my patch and your addendum into keys-next.

Jason
