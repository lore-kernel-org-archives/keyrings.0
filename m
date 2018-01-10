From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 10 Jan 2018 11:12:30 +0000
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/request_key04: new test for request_key() permission check bug
Message-Id: <20180110111229.msrsio6z4d2o4pf4@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <87vagajbhe.fsf@rpws.prws.suse.cz>
In-Reply-To: <87vagajbhe.fsf@rpws.prws.suse.cz>
To: keyrings@vger.kernel.org

> From: Eric Biggers <ebiggers@google.com>

> Add a test for a bug that allowed the request_key() system call to be
> used to add a key to a keyring using only Search permission.  This bug
> was assigned CVE-2017-17807.

> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---

LGTM both commits.
BTW it might be worth to define SAFE_KEYCTL().


Kind regards,
Petr
