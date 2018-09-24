From: Ben Boeckel <mathstuf@gmail.com>
Date: Mon, 24 Sep 2018 11:28:38 +0000
Subject: Questions about keyctl_dh_compute_kdf
Message-Id: <20180924112838.GB20321@rotor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Hi,

I've been updating rust-keyutils[1] to have support for the KDF support (as
a PR since it hasn't landed yet) and I've noticed a few things:

    long keyctl_dh_compute_kdf(
        key_serial_t private, key_serial_t prime, key_serial_t base,
        char *hashname, char *otherinfo, size_t otherinfolen,
        char *buffer, size_t buflen);

  - Should `hashname` be a `const char*`? Does the kernel have any
    reason to write here?
  - Should `otherinfo` be a `const unsigned char*`? Maybe `const void*`?
    If the caller specifies the format, why is it non-const?

The manpage mentions:

    The KDF returns the requested number of bytes specified with the
    genlen or the buflen parameter depending on the invoked function.

but `genlen` isn't mentioned anywhere else in the manpage. I assume the
length is calculated by passing a `NULL` `buffer`, but that's just based
on other APIs in keyutils.

The `keyctl_dh_compute_kdf` function is also missing from the `RETURN
VALUE` section of the manpage.

In addition:

    The hashname specifies the Linux kernel crypto API name for a hash
    that shall be used for the key derivation function, such as sha256.
    The hashname must be a NULL terminated string

A reference to the manpage or header (hash_info.h?) listing these this
would be great.

Thanks!

--Ben

[1]https://github.com/mathstuf/rust-keyutils
