From: Will Deacon <will@kernel.org>
Date: Mon, 27 Apr 2020 11:57:02 +0000
Subject: Re: [RFC PATCH] security/keys: remove possessor verify after key permission check
Message-Id: <20200427115701.GA15889@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

On Mon, Apr 27, 2020 at 02:45:54PM +0300, Алексей Красиков wrote:
>    ping

Hmm, did the original patch make it to the mailing list? I don't see it in
the archives [1], so that might explain the silence.

Will
 
[1] https://www.spinics.net/lists/keyrings/maillist.html

>    "Alexey Krasikov" <alex-krasikov@yandex-team.ru>:
> 
>      In security/keys/keyctl.c: keyctl_read_key() after key_permission()
>      check
>      is called is_key_possessed(). According to the current logic, if the
>      caller is
>      a possessor, then it can read the key regardless of whether it has
>      rights
>      to do so.
> 
>      if I remove the possessor read rights:
>          keyctl_setperm(key, KEY_POS_ALL & (~KEY_POS_SETATTR));
>      the calling process will still be able to read the key if it is
>      possessor.
> 
>      In other words, if the possessor doesn't have read rights, it doesn't
>      matter.
> 
>      ---
>      I may be misunderstanding the logic behind it, but here's the patch to
>      stir the discussion.
> 
>      Signed-off-by: Alexey Krasikov <[1]alex-krasikov@yandex-team.ru>
