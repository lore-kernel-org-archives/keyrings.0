From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 05 May 2020 13:07:00 +0000
Subject: Re: [RESEND] security/keys: remove possessor verify after key permission check
Message-Id: <20200505130440.GA134046@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200505091958.GD16980@willie-the-truck>
In-Reply-To: <20200505091958.GD16980@willie-the-truck>
To: keyrings@vger.kernel.org

On Tue, May 05, 2020 at 10:19:59AM +0100, Will Deacon wrote:
> On Thu, Apr 30, 2020 at 10:34:03AM +0300, Alexey Krasikov wrote:
> > In security/keys/keyctl.c: keyctl_read_key() after key_permission() check
> > is called is_key_possessed(). According to the current logic, if the caller is
> > a possessor, then it can read the key regardless of whether it has rights
> > to do so.
> > 
> > if I remove the possessor read rights:
> >     keyctl_setperm(key, KEY_POS_ALL & (~KEY_POS_SETATTR));
> > the calling process will still be able to read the key if it is possessor.
> > 
> > In other words, if the possessor doesn't have read rights, it doesn't matter.
> > 
> > ---
> > I may be misunderstanding the logic behind it, but here's the patch to
> > stir the discussion.
> > 
> > Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>
> > ---
> >  security/keys/keyctl.c | 15 +--------------
> >  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> Hmm, looks like this still didn't make it to the keyrings@ list :(
> 
> On the off-chance that my reply /does/ make it, I've left the whole of the
> patch intact below. Please can somebody have a look?
> 
> Will

Hi, I'm on this. Just didn't have time last week. Looking it through
on *some* day this week properly.

/Jarkko
