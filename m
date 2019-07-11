From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 11 Jul 2019 03:07:15 +0000
Subject: Re: [GIT PULL] Keys: Set 4 - Key ACLs for 5.3
Message-Id: <1562814435.4014.11.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <28477.1562362239@warthog.procyon.org.uk>
         <CAHk-=wjxoeMJfeBahnWH=9zShKp2bsVy527vo3_y8HfOdhwAAw@mail.gmail.com>
         <20190710194620.GA83443@gmail.com> <20190710201552.GB83443@gmail.com>
         <CAHk-=wiFti6=K2fyAYhx-PSX9ovQPJUNp0FMdV0pDaO_pSx9MQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiFti6=K2fyAYhx-PSX9ovQPJUNp0FMdV0pDaO_pSx9MQ@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, keyrings@vger.kernel.org, Netdev <netdev@vger.kernel.org>, linux-nfs@vger.kernel.org, CIFS <linux-cifs@vger.kernel.org>, linux-afs@lists.infradead.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-integrity@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>

Hi Linus,

On Wed, 2019-07-10 at 18:59 -0700, Linus Torvalds wrote:
> Anyway, since it does seem like David is offline, I've just reverted
> this from my tree, and will be continuing my normal merge window pull
> requests (the other issues I have seen have fixes in their respective
> trees).

Sorry for the delay.  An exception is needed for loading builtin keys
"KEY_ALLOC_BUILT_IN" onto a keyring that is not writable by userspace.
 The following works, but probably is not how David would handle the
exception.

diff --git a/security/keys/key.c b/security/keys/key.c
index 519211a996e7..a99332c1e014 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -896,7 +896,7 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
        /* if we're going to allocate a new key, we're going to have
         * to modify the keyring */
        ret = key_permission(keyring_ref, KEY_NEED_WRITE);
-       if (ret < 0) {
+       if (ret < 0 && !(flags & KEY_ALLOC_BUILT_IN)) {
                key_ref = ERR_PTR(ret);
                goto error_link_end;
        }

Mimi
