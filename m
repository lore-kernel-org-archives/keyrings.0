From: Kairui Song <kasong@redhat.com>
Date: Thu, 17 Jan 2019 16:15:45 +0000
Subject: Re: [RFC PATCH 1/1] KEYS, integrity: Link .platform keyring to .secondary_trusted_keys
Message-Id: <CACPcB9e9ibefCgdMfKjAXV69BOoDWEmLe7K=hGG3UHW0WXeVLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190108081247.2266-1-kasong@redhat.com> <20190108081247.2266-2-kasong@redhat.com>
 <21896.1547737461@warthog.procyon.org.uk>
In-Reply-To: <21896.1547737461@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, Mimi Zohar <zohar@linux.ibm.com>, bauerman@linux.ibm.com, Eric Biggers <ebiggers@google.com>, nayna@linux.ibm.com, Dave Young <dyoung@redhat.com>

On Thu, Jan 17, 2019 at 11:04 PM David Howells <dhowells@redhat.com> wrote:
>
> Kairui Song <kasong@redhat.com> wrote:
>
> > +extern const struct key* __init integrity_get_platform_keyring(void);
>
> This should really be in keys/system_keyring.h and probably shouldn't be
> exposed directly if it can be avoided.
>
> David

Thanks for the review, I've sent V3 of this patch series, the
implementation changed a bit, would you mind take a look of that patch
instead?
https://lore.kernel.org/lkml/20190116101654.7288-1-kasong@redhat.com/

-- 
Best Regards,
Kairui Song
