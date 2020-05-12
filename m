From: David Howells <dhowells@redhat.com>
Date: Tue, 12 May 2020 13:17:05 +0000
Subject: Re: [PATCH v3] security/keys: rewrite big_key crypto to use library interface
Message-Id: <2620780.1589289425@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200511215101.302530-1-Jason@zx2c4.com> <CAHmME9oXiTmVuOYmG=K3ijWK+zP2yB9a2CFjbLx_5fkDiH30Tg@mail.gmail.com>
In-Reply-To: <20200511215101.302530-1-Jason@zx2c4.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, kernel-hardening@lists.openwall.com, Eric Biggers <ebiggers@google.com>

Jason A. Donenfeld <Jason@zx2c4.com> wrote:

> -	/* no ->update(); don't add it without changing big_key_crypt() nonce */
> +	/* no ->update(); don't add it without changing chacha20poly1305's nonce

Note that ->update() doesn't have to modify the contents of the key, but can
just rather replace them entirely.  See attached.  The actual work is done in
big_key_preparse(); all big_key_update() has to do is apply it and dispose of
the old payload.

David
---
commit 724e76c185d517f35ead4f72f9958850c9218f4d
Author: David Howells <dhowells@redhat.com>
Date:   Tue May 12 14:03:53 2020 +0100

    keys: Implement update for the big_key type
    
    Implement the ->update op for the big_key type.
    
    Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/include/keys/big_key-type.h b/include/keys/big_key-type.h
index 3fee04f81439..988d90d77f53 100644
--- a/include/keys/big_key-type.h
+++ b/include/keys/big_key-type.h
@@ -18,5 +18,6 @@ extern void big_key_revoke(struct key *key);
 extern void big_key_destroy(struct key *key);
 extern void big_key_describe(const struct key *big_key, struct seq_file *m);
 extern long big_key_read(const struct key *key, char *buffer, size_t buflen);
+extern int big_key_update(struct key *key, struct key_preparsed_payload *prep);
 
 #endif /* _KEYS_BIG_KEY_TYPE_H */
diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index d43f3daab2b8..dd708e8f13c0 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -47,7 +47,7 @@ struct key_type key_type_big_key = {
 	.destroy		= big_key_destroy,
 	.describe		= big_key_describe,
 	.read			= big_key_read,
-	/* no ->update(); don't add it without changing chacha20poly1305's nonce */
+	.update			= big_key_update,
 };
 
 /*
@@ -191,6 +191,23 @@ void big_key_destroy(struct key *key)
 	key->payload.data[big_key_data] = NULL;
 }
 
+/*
+ * Update a big key
+ */
+int big_key_update(struct key *key, struct key_preparsed_payload *prep)
+{
+	int ret;
+
+	ret = key_payload_reserve(key, prep->datalen);
+	if (ret < 0)
+		return ret;
+
+	if (key_is_positive(key))
+		big_key_destroy(key);
+
+	return generic_key_instantiate(key, prep);
+}
+
 /*
  * describe the big_key key
  */
