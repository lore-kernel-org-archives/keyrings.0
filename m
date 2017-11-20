From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 20 Nov 2017 09:09:03 +0000
Subject: Re: [LTP] [PATCH] syscalls/add_key04: new test for associative array bug
Message-Id: <87shd9iafk.fsf@rpws.prws.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <871sl7q2ht.fsf@rpws.prws.suse.cz>
In-Reply-To: <871sl7q2ht.fsf@rpws.prws.suse.cz>
To: keyrings@vger.kernel.org


Hello,

This looks good to me, except for some nit picking: sprintf could be
snprintf and probably you only need one 'associative'. However I would
be happy for this to be merged as-is.

-- 
Thank you,
Richard.
