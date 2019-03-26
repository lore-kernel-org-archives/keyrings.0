From: Denis Kenzior <denkenz@gmail.com>
Date: Tue, 26 Mar 2019 14:59:40 +0000
Subject: Re: Bad file pattern in MAINTAINERS section 'KEYS-TRUSTED'
Message-Id: <c7f70a06-65a5-a1cd-69c5-dae7567b851f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190325212705.26837-1-joe@perches.com>
 <20190326113725.GA10898@linux.intel.com>
 <1553602220.3960.29.camel@linux.ibm.com>
 <1553610317.2900.2.camel@linux.ibm.com>
In-Reply-To: <1553610317.2900.2.camel@linux.ibm.com>
To: James Bottomley <jejb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, Mimi Zohar <zohar@us.ibm.com>, David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, Marcel Holtmann <marcel@holtmann.org>, James Morris <james.morris@microsoft.com>

Hi James,

On 03/26/2019 09:25 AM, James Bottomley wrote:
> Looking at the contents of linux/keys/trusted.h, it looks like the
> wrong decision to move it.  The contents are way too improperly named
> and duplicative to be in a standard header.  It's mostly actually TPM
> code including a redefinition of the tpm_buf structure, so it doesn't
> even seem to be necessary for trusted keys.
The reason this was done was because asym_tpm.c needed a bunch of the 
same functionality already provided by trusted.c, e.g. TSS_authmac and 
friends.

> 
> If you want to fix this as a bug, I'd move it back again, but long term
> I think it should simply be combined with trusted.c because nothing
> else can include it sanely anyway.

Ideally I'd like to see the TPM subsystem expose these functions using 
some proper API / library abstraction.  David Howells had an RFC patch 
set that tried to address some of this a while back.  Not sure if that 
went anywhere.

Regards,
-Denis
