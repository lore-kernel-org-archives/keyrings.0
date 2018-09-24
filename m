From: Stephan Mueller <smueller@chronox.de>
Date: Mon, 24 Sep 2018 12:05:22 +0000
Subject: Re: Questions about keyctl_dh_compute_kdf
Message-Id: <1711831.bEDBRdJs9Y@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180924112838.GB20321@rotor>
In-Reply-To: <20180924112838.GB20321@rotor>
To: keyrings@vger.kernel.org

Am Montag, 24. September 2018, 13:28:38 CEST schrieb Ben Boeckel:

Hi Ben,

> Hi,
> 
> I've been updating rust-keyutils[1] to have support for the KDF support (as
> a PR since it hasn't landed yet) and I've noticed a few things:
> 
>     long keyctl_dh_compute_kdf(
>         key_serial_t private, key_serial_t prime, key_serial_t base,
>         char *hashname, char *otherinfo, size_t otherinfolen,
>         char *buffer, size_t buflen);
> 
>   - Should `hashname` be a `const char*`? Does the kernel have any
>     reason to write here?
>   - Should `otherinfo` be a `const unsigned char*`? Maybe `const void*`?
>     If the caller specifies the format, why is it non-const?

You are correct, both should be const. The data type of char is appropriate 
and should not be turned into a void. If you have a specific data type for the 
otherinfo data, I think it would be appropriate for the developer to simply 
type-cast it. In general, I would like to avoid a void unless there is no 
other way.
> 
> The manpage mentions:
> 
>     The KDF returns the requested number of bytes specified with the
>     genlen or the buflen parameter depending on the invoked function.
> 
> but `genlen` isn't mentioned anywhere else in the manpage. I assume the
> length is calculated by passing a `NULL` `buffer`, but that's just based
> on other APIs in keyutils.

Actually this is not the case here: you have a KDF which generates exactly the 
requested amount of data unlike the other functions which return a fixed 
amount of data.
> 
> The `keyctl_dh_compute_kdf` function is also missing from the `RETURN
> VALUE` section of the manpage.

The return value is identical as described for the other functions. But you 
are right, it needs to be added to the man page.

Would you care for sending a patch?
> 
> In addition:
> 
>     The hashname specifies the Linux kernel crypto API name for a hash
>     that shall be used for the key derivation function, such as sha256.
>     The hashname must be a NULL terminated string
> 
> A reference to the manpage or header (hash_info.h?) listing these this
> would be great.

There is no header file where this is listed. Instead, /proc/crypto is your 
friend if you have already registered hashes. But you can request new hashes 
of they have not been loaded (or the kernel modules are not yet insmod'ed) 
where the entry will pop up in /proc/crypto at the loading time. Further, it 
is permissible to use the "generic name" as well as the "driver name" (see /
proc/crypto for examples).
> 
> Thanks!
> 
> --Ben
> 
> [1]https://github.com/mathstuf/rust-keyutils

Thanks.

Ciao
Stephan
