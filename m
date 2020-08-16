From: James Bottomley <jejb@linux.ibm.com>
Date: Sun, 16 Aug 2020 16:36:09 +0000
Subject: Re: [PATCH RESEND] docs: update trusted-encrypted.rst
Message-Id: <1597595769.8344.7.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200815075143.47082-1-colyli@suse.de>
         <cf667ea0-dab7-a242-886c-938582c62ff6@linux.ibm.com>
In-Reply-To: <cf667ea0-dab7-a242-886c-938582c62ff6@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, Coly Li <colyli@suse.de>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linux.ibm.com>

On Sun, 2020-08-16 at 12:06 -0400, Stefan Berger wrote:
[...]
> A note in this file states this:
> 
> Note: When using a TPM 2.0 with a persistent key with handle
> 0x81000001, append 'keyhandle=0x81000001' to statements between
> quotes, such as "new 32 keyhandle=0x81000001".
> 
> Now if someone was (still) interested in TPM 1.2 then the below
> changes you are proposing wouldn't work for them. Maybe you should
> adapt the  note to state that these keyhandle=... should be removed
> for the TPM 1.2 case.

Actually, I also have a plan to match what userspace does and simply
assume a keyhandle of 40000001 (generate an EC Storage Primary Key on
the fly) if it's not specified, which will make the TPM1.2 and 2.0
versions of this the same.  Unfortunately the necessary precursor
patches are taking an age to get upstream.

James
