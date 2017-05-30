From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Date: Tue, 30 May 2017 07:10:23 +0000
Subject: verify_pefile_signature() and a message field of MZ header in pe.h
Message-Id: <20170530071022.GB26483@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: dhowells@redhat.com
Cc: ard.biesheuvel@linaro.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

Hi David,

Struct mz_hdr in include/linux/pe.h contains a message[] field.
Should it be part of this structure?
(I googled "MZ format," but didn't find out the exact definition.)

I'm now working on kexec_file_load support on arm64. As arm64's
Image binary can be seen as in PE format, verify_pefile_signature()
is used to assure integrity as on x86.
But this attempt fails (ELIBBAD) at pefile_parse_binary():

        ---8<---
#define chkaddr(base, x, s)                                             \
        do {                                                            \
                if ((x) < base || (s) >= datalen || (x) > datalen - (s)) \
                        return -ELIBBAD;                                \
        } while (0)

        ...

        cursor = sizeof(*mz);

        chkaddr(cursor, mz->peaddr, sizeof(*pe)); <-- Here
        pe = pebuf + mz->peaddr;
        if (pe->magic != PE_MAGIC)
                return -ELIBBAD;
        --->8---

because our Image doesn't have message[] in a pseudo header and so
mz->peaddr is not beyond sizeof(*mz).

I think we can fix this issue, either
(a) remove message[] from struct mz_hdr
(b) modify a check by chkaddr() macro
(c) add a dummy pad into arm64's binary

Which one should we follow here?

Thanks,
-Takahiro AKASHI
