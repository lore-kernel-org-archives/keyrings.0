From: Xiongwei Song <sxwjean@gmail.com>
Date: Mon, 03 Sep 2018 08:31:56 +0000
Subject: Question about pe file verification
Message-Id: <CAEVVKH9sq9oMX0hVen9sX+9GoG=4Y8v7RPMBD_iuZOe9Mgiw1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
To: dhowells@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

Some code logic I don't understand about the function pefile_digest_pe_contents
 in the file crypto/asymmetric_keys/verify_pefile.c.
At the end of pefile_digest_pe_contents, please see the comment [sxw] below:

static int pefile_digest_pe_contents(const void *pebuf, unsigned int pelen,
                     struct pefile_context *ctx,
                     struct shash_desc *desc)
{
    unsigned *canon, tmp, loop, i, hashed_bytes;
    int ret;

    ......
　[sxw] I assume the image has signed by sbsign tool, there is a certificate
             at the end of image file.
    if (pelen > hashed_bytes) {
        tmp = hashed_bytes + ctx->certs_size;
        [sxw] The tmp value is the end of certificate.

        ret = crypto_shash_update(desc,
                      pebuf + hashed_bytes,
                      [sxw] The data address is the beginning of the
certificate.
                               Why do we need to hash the
certification data block?

                      pelen - tmp);
                      [sxw] However, the data length doesn't include
the certificate,
                               sometimes it's zero.

        if (ret < 0)
            return ret;
    }

    return 0;
}

Is that for a special consider or something else?

Regards,
Xiongwei
