From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 07 Jun 2017 13:51:06 +0000
Subject: Re: [LTP] [PATCH 0/2] ltp: update add_key tests for nonempty NULL payload fix
Message-Id: <20170607135106.GC26322@rei.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170606114416.GA5208@rei>
In-Reply-To: <20170606114416.GA5208@rei>
To: keyrings@vger.kernel.org

Hi!
> Personally, I don't align quite as strongly with that viewpoint (and maybe you
> and the other LTP developers don't either) because this can, after all, only be
> a problem in cases where the test suite is upgraded, and furthermore if a test
> fails it's helpful to 'git log' the test anyway.
> 
> Would you suggest I simply update add_key02 instead?

Yes, I would have done that as well.

-- 
Cyril Hrubis
chrubis@suse.cz
