From: Denis Kenzior <denkenz@gmail.com>
Date: Fri, 12 Oct 2018 17:15:55 +0000
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
Message-Id: <8059e3db-ee39-d5a4-b8b4-1cb2c69bf82e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com>
 <20181011203126.15338-1-ndesaulniers@google.com>
 <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com>
 <CAKwvOdmHm_2i6bQa59hw1K1ZoTzdSx9yfNoR66WLr_UCv0Lr1w@mail.gmail.com>
In-Reply-To: <CAKwvOdmHm_2i6bQa59hw1K1ZoTzdSx9yfNoR66WLr_UCv0Lr1w@mail.gmail.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, dhowells@redhat.com, Nathan Chancellor <natechancellor@gmail.com>, Eric Biggers <ebiggers@google.com>, zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi Nick,

>> Refer to
>> https://trustedcomputinggroup.org/wp-content/uploads/TPM-Main-Part-3-Commands_v1.2_rev116_01032011.pdf
>> for details.
> 
>   Can you cite the relevant section?
> 

Just pick any section that describes a TPM command.  I randomly used 
Section 10.3 for TPM Unbind.  See the 'Incoming operands and sizes' table.

Regards,
-Denis
