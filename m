From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 01 Nov 2017 10:59:35 +0000
Subject: Re: [LTP] [PATCH] syscalls/request_key03: new test for key instantiation races
Message-Id: <20171101105935.GA12823@rei.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171031082543.udhds5dvuj42kcqr@dell5510>
In-Reply-To: <20171031082543.udhds5dvuj42kcqr@dell5510>
To: keyrings@vger.kernel.org

Hi!
> > You evaluate test twice: for add_key_pid and then for request_key_pid.
> > This can lead to FAIL and PASS together. It's probably ok, it's just unusual for me.
> > ./request_key03 
> > tst_test.c:958: INFO: Timeout per run is 0h 05m 00s
> > request_key03.c:136: FAIL: kernel oops while updating key of type 'encrypted'
> > request_key03.c:144: PASS: didn't crash while requesting key of type 'encrypted'
> > ...
> > 
> 
> Would it be better if there was just one PASS, and it is only executed if
> neither of the FAILs was reached?

Frankly I do not care that much in this case, the messages are pretty
clear on what is happening.

The only thing I find a bit confusing is that we run the test twice for
different CVEs and if one of them fails, both of them are marked as
failed. It would be cleaner to pass optional parameter to the test for
which CVE we are looking for and fail the test only if the operation we
are interested in caused the oops. And, of course, fail on any if the
test was executed without it. Otherwise I'm fine with the code as it is.

-- 
Cyril Hrubis
chrubis@suse.cz
