From: Vitaly Chikunov <vt@altlinux.org>
Date: Thu, 28 Feb 2019 18:39:23 +0000
Subject: Re: [PATCH v5 04/10] crypto: akcipher - new verify API for public key algorithms
Message-Id: <20190228183923.5klzwli5zmeew54j@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190224060828.2527-5-vt@altlinux.org>
 <20190224060828.2527-1-vt@altlinux.org>
 <14843.1551377934@warthog.procyon.org.uk>
In-Reply-To: <14843.1551377934@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

David,

On Thu, Feb 28, 2019 at 06:18:54PM +0000, David Howells wrote:
> Vitaly Chikunov <vt@altlinux.org> wrote:
> 
> > +	digest = kmemdup(sig->digest, sig->digest_size, GFP_KERNEL);
> > +	if (!digest)
> 
> You shouldn't need to copy the digest.  It's being passed in to the crypto
> algorithm, not extracted out.

That's how Herbert suggested to do it. Quoting FYI:

| On Fri, Feb 01, 2019 at 02:26:55PM +0800, Herbert Xu wrote:
| > On Fri, Jan 25, 2019 at 09:01:16PM +0300, Vitaly Chikunov wrote:
| > >
| > > @@ -781,36 +780,17 @@ static int tpm_key_verify_signature(const struct key *key,
| > >     if (!req)
| > >             goto error_free_tfm;
| > >
| > > -   ret = -ENOMEM;
| > > -   outlen = crypto_akcipher_maxsize(tfm);
| > > -   output = kmalloc(outlen, GFP_KERNEL);
| > > -   if (!output)
| > > -           goto error_free_req;
| > > -
| > > -   sg_init_one(&sig_sg, sig->s, sig->s_size);
| > > -   sg_init_one(&digest_sg, output, outlen);
| > > -   akcipher_request_set_crypt(req, &sig_sg, &digest_sg, sig->s_size,
| > > -                              outlen);
| > > +   sg_init_table(&src_sg, 2);
| > > +   sg_set_buf(&src_sg[0], sig->s, sig->s_size);
| > > +   sg_set_buf(&src_sg[1], sig->digest, sig->digest_size);
| > > +   akcipher_request_set_crypt(req, &src_sg, NULL, sig->s_size,
| > > +                              sig->digest_size);
| >
| > It's not clear that sig->digest is guaranteed to be kmalloc memory.
| > In any case, it's best not to mix unrelated changes in a single
| > patch.  So please keep the kmalloc on output and then copy
| > sig->digest into it and put output into the SG list.


> > +		if (memcmp(c, outbuf_enc, c_size)) {
> 
> Please use = 0 and != 0 with memcmp() and strcmp().  Their return values are
> kind of inverted in sense if you treat them as boolean.

OK.

Thanks!
