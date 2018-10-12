From: Denis Kenzior <denkenz@gmail.com>
Date: Fri, 12 Oct 2018 15:13:56 +0000
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
Message-Id: <fc23168b-7275-bae0-6039-04e261b3cbad@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com>
 <20181011203126.15338-1-ndesaulniers@google.com>
 <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com>
 <1539356751.2656.5.camel@linux.ibm.com>
In-Reply-To: <1539356751.2656.5.camel@linux.ibm.com>
To: James Bottomley <jejb@linux.ibm.com>, ndesaulniers@google.com, dhowells@redhat.com
Cc: natechancellor@gmail.com, ebiggers@google.com, Mimi Zohar <zohar@linux.vnet.ibm.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Hi James,

>> So can't we simply use 'bool' or uint32 as the type for h3 instead
>> of re-ordering everything
> 
> The problem is the standard is ambiguious.  The only thing that's
> guaranteed to work for all time is a char *.  If you want to keep the
> order, what I'd suggest is inserting a dummy pointer argument which is
> always expected to be NULL between the h3 and the varargs.

So maybe I'm misunderstanding something, but the issue seems to be that 
unsigned char is promoted to 'unsigned char *' by Clang and probably 
unsigned int or int by gcc.

So instead of having unsigned char h3, can't we simply have bool h3 or 
unsigned int h3?

Regards,
-Denis
