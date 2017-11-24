From: Stephan Mueller <smueller@chronox.de>
Date: Fri, 24 Nov 2017 15:03:15 +0000
Subject: Re: x509 parsing bug + fuzzing crypto in the userspace
Message-Id: <2926823.qMJ9kpMUtP@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAG_fn=XJZG_MJXXgos5jZmOThKho=uSvwgfhkMSYONZ04PKKaw@mail.gmail.com> <3132962.8EQ63lqCxc@tauon.chronox.de> <CACT4Y+Zp39AMymVXB8ZdGA1VRYwRVsouuEXdhY3nmP5oawcfEQ@mail.gmail.com>
In-Reply-To: <CACT4Y+Zp39AMymVXB8ZdGA1VRYwRVsouuEXdhY3nmP5oawcfEQ@mail.gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Eric Biggers <ebiggers@google.com>, Alexander Potapenko <glider@google.com>, linux-crypto@vger.kernel.org, Kostya Serebryany <kcc@google.com>, keyrings@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>

Am Freitag, 24. November 2017, 14:49:49 CET schrieb Dmitry Vyukov:

Hi Dmitry,

> I've cooked syzkaller change that teaches it to generate more
> algorithm names. Probably not idea, but much better than was before:
> https://github.com/google/syzkaller/blob/ddf7b3e0655cf6dfeacfe509e477c1486d2
> cc7db/sys/linux/alg.go

I am not as fluent in GO, so I may miss a point here:

		{"authencesn", []int{ALG_HASH, ALG_BLKCIPHER}},
		{"authenc", []int{ALG_HASH, ALG_BLKCIPHER}},

These both are templates to form an AEAD cipher. They allow you to specify the 
block cipher and the hash type.


		{"rfc7539esp", []int{ALG_BLKCIPHER, ALG_HASH}},
		{"rfc7539", []int{ALG_BLKCIPHER, ALG_HASH}},
		{"rfc4543", []int{ALG_AEAD}},
		{"rfc4106", []int{ALG_AEAD}},

These are no ciphers per se, but simply formatting mechanisms. For example, to 
make use of rfc4106, you must split the IV: the first four bytes need to be 
appended to the key and the trailing 8 bytes are used as the IV. Any other 
formatting should cause an error. Besides, these implementations should only 
work with some AEAD ciphers like GCM.


		{"pcrypt", []int{ALG_AEAD}},
		{"rfc4309", []int{ALG_AEAD}},
		{"gcm", []int{ALG_CIPHER}},
		{"gcm_base", []int{ALG_BLKCIPHER, ALG_HASH}},
		{"ccm", []int{ALG_CIPHER}},
		{"ccm_base", []int{ALG_BLKCIPHER, ALG_HASH}},




		{"echainiv", []int{ALG_AEAD}},
{"seqiv", []int{ALG_AEAD}},

These are IV generators and should be used with an AEAD cipher to internally 
generate IVs. Note, the use of IV generators have changed with 4.2 (see my 
script I sent you as part of this thread).



		{"gcm(aes)", nil},

gcm() is also a template that can consume any block cipher, including aes-
generic, serpent, ...

		{"gcm_base(ctr(aes-aesni),ghash-generic)", nil},

Again, ctr() is a template that can consume other block ciphers.

		{"generic-gcm-aesni", nil},

Does this exist?

		{"rfc4106(gcm(aes))", nil},

rfc... is a template that can consume AEAD ciphers.

		{"rfc4106-gcm-aesni", nil},
		{"__gcm-aes-aesni", nil},
{"__driver-gcm-aes-aesni", nil},

Please specifically test that __driver_... names should NEVER be allocatable 
from user space.



	// algorithms:
		{"cbc(aes)", nil},

cbc() is a template


		{"cbc(aes-aesni)", nil},
		{"chacha20", nil},
		{"chacha20-simd", nil},
		{"pcbc(aes)", nil},
		{"pcbc-aes-aesni", nil},
		{"fpu(pcbc(__aes))", nil},
		{"fpu(pcbc(__aes-aesni))", nil},
		{"pcbc(__aes)", nil},
		{"pcbc(__aes-aesni)", nil},

They are all templates.

		{"xts(aes)", nil},

xts() is a template.

Note, starting with 4.9, you must use xts(ecb(aes)).

		{"xts-aes-aesni", nil},
{"ctr(aes)", nil},

ctr() is a template



In general, I would rather suggest:

1. identify all templates and mark them what they can consume (other 
templates, AEAD, skcipher, hash, ...)

2. identify all ciphers (aes, aes-generic, aes-aesni, ...) and identify their 
types (skcipher, hash)

3. mix-n-match templates with the ciphers according to what templates can 
consume


Start another test where you arbitrarily mix-n-match templates and ciphers or 
even bogus names, NULL, etc.


One word of warning: some cipher names may look like templates, but they are 
not: gcm(aes) in arch/x86/crypto/ is a complete cipher and not consisting of 
templates. Thus, I would always use the driver names (gcm-aes-aesni for the 
given example) to ensure you test exactly the cipher you had in mind.

Word of warning II: There is a bug in the kernel crypto API: if you allocate a 
cipher using the driver name that was not registered before, this cipher will 
never be available using its "name". /proc/crypto shows you the reason: the 
"name" is then identical to the driver name.

Ciao
Stephan
