Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852120;
	b=oXA9N+sCQ1q4X55Awpz/eOJfBz/UhR+ETmE0VGbeRWqCD2u+xAc1we22M1y96LOgYWXX
	 We26yXjlLCusAUEMtXWgQTAm4D4I7sxVrwM4K98P9atTtmfNVEadHR7nFRIrynd4Xzzy8
	 Zsei1KntfBIrT22lnhJet01DBTUMpLHE2A/B/o3YDd7cL1W75FSLT1QqayMsRvZeS1Xe0
	 OgeCJCHTCqJPhlf+v39qe1dpyf6r7XOyvzL6zjt8FcyA2Vc4Qtd2FL/QLpqT3xREjZcQ5
	 yCYjEy6Xurt2RghF+b4wWN38OpnfI+4foyhH9Ci1BgCpahAmtFwZQfHXv+SQd5fSTdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852120;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Z628nHYfCWBiZSp+0Tr5bLdRHNW+dF809qGkRXHjCzA=;
	b=kSB9+hKOV02r4ZOArPWcbakzB+zouu72Ky2Qw9OHg6PKcIURJlEcG5ovMsCb6c8BeTJV
	 c+qs/y6YObfHjpk138wkx1E1WW6PS0175kJd8pqscVVmq+l16HWDFO0GOh1cbFl9YyrZg
	 tFEXu0vrFEywWIAjMMsrPZIudUtL5qmRjW1oP3sF1R0fOkZ7rIYbq7fgmJ2cDrXMAmrm/
	 xbroRqp6h7GqQ0VQYJDEVatmK+OhfYee0lxbd5usj5qiJpMjbc5VgYG55KMtRr09Egnok
	 Nh9HoBxljTXcnz1OH/GZug6poT/qfZM1IQBdV3ci6NvbpwExbk/hiFJE2CJkIcF9nFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d43tGz5W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E154A606A31A;
	Sat, 24 Oct 2026 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d43tGz5W
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 019A91F01825;
	Sat, 24 Oct 2026 14:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792852119;
	bh=Z628nHYfCWBiZSp+0Tr5bLdRHNW+dF809qGkRXHjCzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d43tGz5W71HBVehKkUyqv+xSEIHwi6vD9Q8RrtEEoXejltcJa/QmnuS4ffEJMGHQV
	 9BTbdPkvdgu1jsle8CIvBA3uU6OXkoucVNF1Jr6+j/n5RKzCjFDLktqKyjum0LGqzc
	 rnHmdm4Esk4MCZ6BA1UrFfH2IKs6O6qDH5Lgu1tnuDzJYmClALHuUb8EuwhfQCdwx8
	 ajgbMZARrfPWhlJbfCAQrouwAKNdbV9UhxZuqHQrONv//X6iVXRDgTdcAhyCYW7QQP
	 XSS/bXTtqmM1tc6IwnX6quyjss3b57ZNk6dGwImBoFTM7XQ2cmmmgRb2muhzqtvWHz
	 4A/q5LWJhrW6w==
Date: Sat, 24 Oct 2026 17:28:35 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] KEYS: Replace assoc_array with rhashtable
Message-ID: <atzAk-1IhxTN5nk8@kernel.org>
References: <20261023120953.1206778-1-jarkko@kernel.org>
 <20261023120953.1206778-6-jarkko@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023120953.1206778-6-jarkko@kernel.org>

On Fri, Oct 23, 2026 at 03:09:25PM +0300, Jarkko Sakkinen wrote:
> @@ -516,8 +507,7 @@ static long keyring_read(const struct key *keyring,
>  		ctx.buffer = (key_serial_t *)buffer;
>  		ctx.buflen = buflen;
>  		ctx.count = 0;
> -		ret = assoc_array_iterate(&keyring->keys,
> -					  keyring_read_iterator, &ctx);
> +		ret = keyring_iterate(keyring, keyring_read_iterator, &ctx);
>  		if (ret < 0) {
>  			kleave(" = %ld [iterate]", ret);
>  			return ret;
> @@ -525,7 +515,7 @@ static long keyring_read(const struct key *keyring,
>  	}
>  
>  	/* Return the size of the buffer needed */
> -	ret = keyring->keys.nr_leaves_on_tree * sizeof(key_serial_t);
> +	ret = keyring_nr_links(keyring) * sizeof(key_serial_t);
>  	if (ret <= buflen)
>  		kleave("= %ld [ok]", ret);
>  	else

I changed this a bit because I wanted to bake cond_resched() between the
iterations. I'd be interested getting feedback about the change below.

I.e. in my working branch I have this laid out as follows:

-struct keyring_read_iterator_context {
-	size_t			buflen;
-	size_t			count;
-	key_serial_t		*buffer;
-};
-
-static int keyring_read_iterator(const void *object, void *data)
-{
-	struct keyring_read_iterator_context *ctx = data;
-	const struct key *key = keyring_ptr_to_key(object);
-
-	kenter("{%s,%d},,{%zu/%zu}",
-	       key->type->name, key->serial, ctx->count, ctx->buflen);
-
-	if (ctx->count >= ctx->buflen)
-		return 1;
-
-	*ctx->buffer++ = key->serial;
-	ctx->count += sizeof(key->serial);
-	return 0;
-}
-
 /*
  * Read a list of key IDs from the keyring's contents in binary form
  *
@@ -503,7 +473,10 @@ static int keyring_read_iterator(const void *object, void *data)
 static long keyring_read(const struct key *keyring,
 			 char *buffer, size_t buflen)
 {
-	struct keyring_read_iterator_context ctx;
+	struct keyring_index *links = keyring_index_locked(keyring);
+	struct keyring_link *link;
+	key_serial_t *serials = (key_serial_t *)buffer;
+	size_t count = 0;
 	long ret;

 	kenter("{%d},,%zu", key_serial(keyring), buflen);
@@ -512,20 +485,18 @@ static long keyring_read(const struct key *keyring,
 		return -EINVAL;

 	/* Copy as many key IDs as fit into the buffer */
-	if (buffer && buflen) {
-		ctx.buffer = (key_serial_t *)buffer;
-		ctx.buflen = buflen;
-		ctx.count = 0;
-		ret = assoc_array_iterate(&keyring->keys,
-					  keyring_read_iterator, &ctx);
-		if (ret < 0) {
-			kleave(" = %ld [iterate]", ret);
-			return ret;
+	if (buffer && buflen && links) {
+		list_for_each_entry(link, &links->list, list) {
+			if (count == buflen / sizeof(*serials))
+				break;
+
+			serials[count++] = keyring_link_key(link)->serial;
+			cond_resched();
 		}
 	}

 	/* Return the size of the buffer needed */
-	ret = keyring->keys.nr_leaves_on_tree * sizeof(key_serial_t);
+	ret = links ? links->nr * sizeof(key_serial_t) : 0;
 	if (ret <= buflen)
 		kleave("= %ld [ok]", ret);
 	else

What do you think about this? I'm worried about blind spot mainly
because this feels too obvious.

Br, Jarkko
