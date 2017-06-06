From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 06 Jun 2017 11:55:52 +0000
Subject: Re: [LTP] [PATCH 0/2] ltp: update add_key tests for nonempty NULL payload fix
Message-Id: <20170606114416.GA5208@rei>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Hi!
> (The reason I'm not simply changing the add_key02 test is that I don't want it
> to appear as a regression on old kernels.  I'm not sure exactly how this kind of
> thing is typically handled in LTP, though.)

What exactly do you mean by a regression here? The fact that it may
crash older kernels? That is pretty much fine, when test fails/kernel
crashes manual intervention is required and one of the first things you
do is git log for the test.

-- 
Cyril Hrubis
chrubis@suse.cz
