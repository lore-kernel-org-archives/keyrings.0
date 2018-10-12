From: Denis Kenzior <denkenz@gmail.com>
Date: Fri, 12 Oct 2018 15:53:43 +0000
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
Message-Id: <da2a675f-bd2d-a1f3-6a67-5579e75bdb76@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com>
 <20181011203126.15338-1-ndesaulniers@google.com>
 <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com>
 <1539356751.2656.5.camel@linux.ibm.com>
 <fc23168b-7275-bae0-6039-04e261b3cbad@gmail.com>
 <1539357759.2656.7.camel@linux.ibm.com>
 <16de2bb3-815a-f534-4618-af854c906017@gmail.com>
 <1539359181.2656.13.camel@linux.ibm.com>
In-Reply-To: <1539359181.2656.13.camel@linux.ibm.com>
To: James Bottomley <jejb@linux.ibm.com>, ndesaulniers@google.com, dhowells@redhat.com
Cc: natechancellor@gmail.com, ebiggers@google.com, Mimi Zohar <zohar@linux.vnet.ibm.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Hi James,

>>   From the links provided in the patch it seems that one cannot pass
>> char/float/short to va_start().  Fair enough.  So if we make h3 an
>> unsigned int, the issue goes away, no?
> 
> For the current version of clang, yes.  However, if we're fixing this
> for good a char * pointer is the only guaranteed thing because it
> mirrors current use in printf.
> 

All right.  I guess I wasn't aware that non-printf like variadic 
functions are now considered harmful or of the impending crusade against 
them :)

But in the context of this patch, can we please use something less 
invasive than changing all the arguments around?  Promoting h3 to a bool 
(if possible) or int/unsigned int would get my vote.

Regards,
-Denis
