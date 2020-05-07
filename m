From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 07 May 2020 07:24:08 +0000
Subject: Re: [RESEND] security/keys: remove possessor verify after key permission check
Message-Id: <d0c93316324c3815cb4f9f1c5423530c5e363111.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200505091958.GD16980@willie-the-truck>
In-Reply-To: <20200505091958.GD16980@willie-the-truck>
To: keyrings@vger.kernel.org

On Thu, 2020-04-30 at 10:34 +0300, Alexey Krasikov wrote:
> In security/keys/keyctl.c: keyctl_read_key() after key_permission() check
> is called is_key_possessed(). According to the current logic, if the caller is
> a possessor, then it can read the key regardless of whether it has rights
> to do so.
> 
> if I remove the possessor read rights:
>     keyctl_setperm(key, KEY_POS_ALL & (~KEY_POS_SETATTR));
> the calling process will still be able to read the key if it is possessor.
> 
> In other words, if the possessor doesn't have read rights, it doesn't matter.
> 
> ---
> I may be misunderstanding the logic behind it, but here's the patch to
> stir the discussion.
> 
> Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>

Tried this:

$ KEYID=$(keyctl add user john smith @u)
$ keyctl setperm $KEYID 0x20000000
$ keyctl read $KEYID
keyctl_read_alloc: Permission denied

You did not provide a full example like this so I have to assume that
this is what you meant.

/Jarkko
