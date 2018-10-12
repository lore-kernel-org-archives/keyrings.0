From: Denis Kenzior <denkenz@gmail.com>
Date: Fri, 12 Oct 2018 17:27:00 +0000
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
Message-Id: <80837c90-0425-aadd-38d7-c3c866d29a0a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com>
 <20181011203126.15338-1-ndesaulniers@google.com>
 <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com>
 <1539356751.2656.5.camel@linux.ibm.com>
 <fc23168b-7275-bae0-6039-04e261b3cbad@gmail.com>
 <CAKwvOdmStDm3Lz=W7XjmB7f7ihe4hLOmaBRLOrStbkBMRKwdjA@mail.gmail.com>
In-Reply-To: <CAKwvOdmStDm3Lz=W7XjmB7f7ihe4hLOmaBRLOrStbkBMRKwdjA@mail.gmail.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: jejb@linux.ibm.com, dhowells@redhat.com, Nathan Chancellor <natechancellor@gmail.com>, Eric Biggers <ebiggers@google.com>, zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi Nick,

>> So maybe I'm misunderstanding something, but the issue seems to be that
>> unsigned char is promoted to 'unsigned char *' by Clang and probably
>> unsigned int or int by gcc.
> 
> No. This is extremely well defined behavior in C.  In C, integral
> types are NEVER promoted to pointer to integer types, only to larger
> integral types through rules more complicated than the correct flags
> to pass to `tar`.
> https://xkcd.com/1168/
> 

Ah right.  Thanks for the correction.  So looks like bool won't work for 
the same reasons.  But unsigned int should work right?  But then again 
this is a boolean value and if we want to be paranoid we can simply 
tweak the 'c = h3' assignment to be something like:

c = !!h3;

So in the end, I'm happy with int or unsigned int.

Regards,
-Denis
