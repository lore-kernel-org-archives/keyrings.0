From: Ben Boeckel <me@benboeckel.net>
Date: Sat, 16 May 2020 00:19:49 +0000
Subject: keyctl_pkey_decrypt / keyctl_pkey_encrypt size mismatch?
Message-Id: <20200516001949.GA1034557@erythro.dev.benboeckel.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Hi,

I'm looking at `keyctl_pkey_decrypt` and I see its call in libkeyutils
is:

	out = malloc(result.max_enc_size);
	if (!out)
		error("malloc");

	out_len = keyctl_pkey_decrypt(key, info,
				      in, in_len, out, result.max_enc_size);

`keyctl_pkey_encrypt` uses `max_dec_size` too. The kernel docs mention
these fields as:

     ``max_*_size`` indicate the maximum sizes in bytes of a blob of data to be
     signed, a signature blob, a blob to be encrypted and a blob to be
     decrypted.

which would make me think that the code is wrong since I read this as
`max_enc_size` is the maximum to-be-encrypted size, not the max size for
a decryption result buffer.

However, it would seem the code actually works since such a buffer
length mismatch seems like *someone* would have made some noise. Some
investigation shows that it could be coincidence as both lengths are
acutally the same[1] (in at least some cases). Unfortunately, no pkey
tests exist in libkeyutils, so the documentation could just be unclear.
Should the documentation instead spell out each `max_X_size` entry
explicitly and list their usage in "respectively" order or get a new
paragraph for each? Or is this just a bug in libkeyutils?

Thanks,

--Ben

[1]See the commit message in c08fed73712620eb0a19244dbbbbdf00edbe5e47:

    # keyctl pkey_query $j - enc=pkcs1
    key_size@96
    max_data_sizeQ2
    max_sig_sizeQ2
    max_enc_sizeQ2
    max_dec_sizeQ2
    encrypt=y
    decrypt=y
    sign=y
    verify=y
