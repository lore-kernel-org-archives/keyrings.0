From: David Howells <dhowells@redhat.com>
Date: Thu, 02 Aug 2018 15:45:33 +0000
Subject: Re: [RFCv2 RESEND 04/13] KEYS: asym_tpm: extract key size & public key
Message-Id: <5082.1533224733@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180719183011.8574-5-denkenz@gmail.com>
In-Reply-To: <20180719183011.8574-5-denkenz@gmail.com>
To: keyrings@vger.kernel.org

Denis Kenzior <denkenz@gmail.com> wrote:

Note that I've pulled my keys-asym-keyctl branch up to linus/master and
repushed.  All your patches apply without issue, but patch #4 is broken:

> +	tk->key_len = key_len;
> +	tk->pub_key = pub_key;
> +	tk->pub_key_len = sz;

This does not compile.

../crypto/asymmetric_keys/asym_tpm.c: In function 'extract_key_parameters':
../crypto/asymmetric_keys/asym_tpm.c:144:6: error: 'struct tpm_key' has no member named 'key_len'; did you mean 'blob_len'?
  tk->key_len = key_len;
      ^~~~~~~
      blob_len
../crypto/asymmetric_keys/asym_tpm.c:145:4: error: 'struct tpm_key' has no member named 'pub_key'
  tk->pub_key = pub_key;
    ^~
../crypto/asymmetric_keys/asym_tpm.c:146:4: error: 'struct tpm_key' has no member named 'pub_key_len'
  tk->pub_key_len = sz;

David
