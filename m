From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 12 May 2020 21:38:37 +0000
Subject: Re: [PATCH v3] security/keys: rewrite big_key crypto to use library interface
Message-Id: <CAHmME9q-TxHo5o63rxHzKwV_kWV9u+MoxBQM5Yz3hODGCj7RhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHmME9oXiTmVuOYmG=K3ijWK+zP2yB9a2CFjbLx_5fkDiH30Tg@mail.gmail.com>
 <20200511215101.302530-1-Jason@zx2c4.com> <2620780.1589289425@warthog.procyon.org.uk>
In-Reply-To: <2620780.1589289425@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, kernel-hardening@lists.openwall.com, Eric Biggers <ebiggers@google.com>

Hi David,

So long as that ->update function:
1. Deletes the old on-disk data.
2. Deletes the old key from the inode.
3. Generates a new key using get_random_bytes.
4. Stores that new key in the inode.
5. Encrypts the updated data afresh with the new key.
6. Puts the updated data onto disk,

then this is fine with me, and feel free to have my Acked-by if you
want. But if it doesn't do that -- i.e. if it tries to reuse the old
key or similar -- then this isn't fine. But it sounds like from what
you've described that things are actually fine, in which case, I guess
it makes sense to apply your patch ontop of mine and commit these.

Jason
