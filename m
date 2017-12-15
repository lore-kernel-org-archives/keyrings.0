From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Fri, 15 Dec 2017 05:08:22 +0000
Subject: Re: [question] should 363b02dab09b3 be backported to stable 4.1+?
Message-Id: <20171215050822.GD11199@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171215024706.GB11199@jagdpanzerIV>
	<20171215035800.GA891@zzz.localdomain>
In-Reply-To: <20171215035800.GA891@zzz.localdomain>
To: linux-security-module@vger.kernel.org

Hello Eric,

On (12/14/17 19:58), Eric Biggers wrote:
> Hi Sergey,
> 
> On Fri, Dec 15, 2017 at 11:47:06AM +0900, Sergey Senozhatsky wrote:
> > Hello David, Eric,
> > 
> > please help me out.
> > 
> > I'm looking at 363b02dab09b ("KEYS: Fix race between updating and finding
> > a negative key") right now. So, I see that it has been backported to stable
> > 4.4+. My question is -- do we have those test_bit(KEY_FLAG_INSTANTIATED)
> > and test_bit(KEY_FLAG_NEGATIVE) races in stable 4.1?
> > 
> 
> Before 4.4 (146aa8b1453), ->reject_error was in union with ->type_data rather
> than ->payload, and no key types that used ->type_data implemented ->update().
> Therefore it was not possible to reproduce the crash.
> 
> I do see there was another possible race, only theoretically a problem on
> architectures with weaker memory ordering than x86, where a key being negatively
> instantiated could be momentarily observed to be positively instantiated.  But
> even then I don't see where it could be a real problem.  (Note that most users
> wait for KEY_FLAG_USER_CONSTRUCT rather than checking KEY_FLAG_INSTANTIATED
> directly.)

thanks a ton. appreciate your help!

> You're free to backport the commit if you want to be absolutely sure, though I'd
> personally be more worried about other backports that might have been missed,
> and the bugs that haven't been found yet.

agreed.

	-ss
