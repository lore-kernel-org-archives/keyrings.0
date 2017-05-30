From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 30 May 2017 09:41:23 +0000
Subject: Re: verify_pefile_signature() and a message field of MZ header in pe.h
Message-Id: <CAKv+Gu9SPsqv26Yyc1Q0-KozFZNUHKdVv-Adi6Scaucf1WnjEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170530071022.GB26483@linaro.org>
In-Reply-To: <20170530071022.GB26483@linaro.org>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, David Howells <dhowells@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, keyrings@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 30 May 2017 at 07:10, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> Hi David,
>
> Struct mz_hdr in include/linux/pe.h contains a message[] field.
> Should it be part of this structure?
> (I googled "MZ format," but didn't find out the exact definition.)
>

MZ format does not exist. It is the magic number of the DOS header,
and MZ are the initials of one of the MS-DOS developers.

> I'm now working on kexec_file_load support on arm64. As arm64's
> Image binary can be seen as in PE format, verify_pefile_signature()
> is used to assure integrity as on x86.
> But this attempt fails (ELIBBAD) at pefile_parse_binary():
>
>         ---8<---
> #define chkaddr(base, x, s)                                             \
>         do {                                                            \
>                 if ((x) < base || (s) >= datalen || (x) > datalen - (s)) \
>                         return -ELIBBAD;                                \
>         } while (0)
>
>         ...
>
>         cursor = sizeof(*mz);
>
>         chkaddr(cursor, mz->peaddr, sizeof(*pe)); <-- Here
>         pe = pebuf + mz->peaddr;
>         if (pe->magic != PE_MAGIC)
>                 return -ELIBBAD;
>         --->8---
>
> because our Image doesn't have message[] in a pseudo header and so
> mz->peaddr is not beyond sizeof(*mz).
>
> I think we can fix this issue, either
> (a) remove message[] from struct mz_hdr
> (b) modify a check by chkaddr() macro
> (c) add a dummy pad into arm64's binary
>
> Which one should we follow here?
>

I think the simplest yet correct approach is to omit the size from
'message', i.e.,

diff --git a/include/linux/pe.h b/include/linux/pe.h
index e170b95e763b..dbcd36ce9e49 100644
--- a/include/linux/pe.h
+++ b/include/linux/pe.h
@@ -43,7 +43,7 @@ struct mz_hdr {
        uint16_t oem_info;      /* oem specific */
        uint16_t reserved1[10]; /* reserved */
        uint32_t peaddr;        /* address of pe header */
-       char     message[64];   /* message to print */
+       char     message[];     /* message to print */
 };

 struct mz_reloc {

This is appropriate since we are not parsing random MS-DOS files here
but PE/COFF binaries, and the PE/COFF spec does not specify a minimum
size for the so-called MS-DOS stub, which populates the region between
the DOS and PE headers. It does specify that its purpose is MS-DOS 2.0
compatibility, which seems a bit pointless for PE/COFF on ARM/arm64
systems.
