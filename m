From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 18 Aug 2017 13:38:03 +0000
Subject: Re: [LTP] [PATCH v2] syscalls/keyctl04: new test for thread keyring memory leak
Message-Id: <20170818133802.GE22319@rei.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Hi!
I've added a lapi/keyctl.h header to LTP with a fallback definitions,
which is more or less standard way how we deal with possibly missing
headers since that way we get to use the one available on system if
present and changed the tests to make use of it.

And pushed both patches, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
