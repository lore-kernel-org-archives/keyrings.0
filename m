From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Oct 2017 09:23:44 +0000
Subject: Re: [LTP] [PATCH v4] syscalls/keyctl07: new test for oops when reading negative key
Message-Id: <20171025092344.GE4244@rei>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Hi!
> Add a test for a bug which caused the kernel to dereference a bogus
> pointer when using KEYCTL_READ to read from a negative key.

Thanks a lot for the updated version, pushed.

-- 
Cyril Hrubis
chrubis@suse.cz
