From: Denis Kenzior <denkenz@gmail.com>
Date: Tue, 18 Sep 2018 04:34:45 +0000
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
Message-Id: <fdee179b-cfdf-7a2b-3193-e114f0084ecb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
	<1537253993.20009.62.camel@infradead.org>
In-Reply-To: <1537253993.20009.62.camel@infradead.org>
To: linux-security-module@vger.kernel.org

Hi David,

On 09/18/2018 01:59 AM, David Woodhouse wrote:
> On Wed, 2018-09-05 at 22:54 +0100, David Howells wrote:
>>
>> Example usage for a PKCS#8 blob:
>>
>>          j=`openssl pkcs8 -in private_key.pem -topk8 -nocrypt -outform DER | \
>>              keyctl padd asymmetric foo @s`

The kernel expects a raw DER formatted PKCS8 certificate.  And as you 
point out, keyctl doesn't grok PEM files.  So, that is why this is being 
done via openssl.  The example above simply shows one how to import a 
private key in PEM format into the kernel keys framework.

>>
>> Example usage for a TPM wrapped blob:
>>
>>          openssl genrsa -out /tmp/privkey.foo.pem 2048
>>          create_tpm_key -s 2048 -w /tmp/privkey.foo.pem /tmp/privkey.foo.tpm
>>          j=`openssl asn1parse -inform pem -in /tmp/privkey.foo.tpm -noout |
>>              keyctl padd asymmetric foo @s`
> 
> Those examples aren't equivalent. For the PKCS#8 blob you are first
> using openssl to convert from an encrypted PKCS#8 PEM to unencrypted
> DER, presumably because you haven't added decryption support (or base64
> decode) to keyctl yet.

To be pedantic, it converts an optionally encrypted PEM to unencrypted 
DER.  But yes, correct.

> 
> For the TPM example though, you are also showing the *generation* of
> the key, and importing it into the TPM. And then I'm confused by the
> 'openssl asn1parse' line there... what is that actually doing? If I run
> it on a '-----BEGIN TSS KEY BLOB-----' file I have lying around, I get
> no output at all.
> 

Same thing applies as above.  The kernel has no PEM parser, so the raw 
DER must be passed in.  openssl asn1parse line simply does that.  It 
strips the PEM layer leaving the raw DER.

However, now that you mention it, the actual command incantation is 
wrong.  It seems openssl asn1parse acts slightly different from openssl 
pkcs8 and so it needs to be modified to add an extra -out parameter.  So 
the example incantation should be:

   openssl genrsa -out /tmp/privkey.2048.pem 2048
   create_tpm_key -s 2048 -w /tmp/privkey.2048.pem /tmp/privkey.2048.tpm
   openssl asn1parse -inform pem -in /tmp/privkey.2048.tpm -noout \
			-out /tmp/privkey.2048.der
   j=`cat /tmp/privkey.2048.der | keyctl padd asymmetric tpm @u`
   echo "TPM key serial is: $j"

Sorry, I should have caught this earlier.

Regards,
-Denis
