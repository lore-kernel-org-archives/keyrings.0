From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Fri, 15 Dec 2017 02:47:06 +0000
Subject: [question] should 363b02dab09b3 be backported to stable 4.1+?
Message-Id: <20171215024706.GB11199@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

Hello David, Eric,

please help me out.

I'm looking at 363b02dab09b ("KEYS: Fix race between updating and finding
a negative key") right now. So, I see that it has been backported to stable
4.4+. My question is -- do we have those test_bit(KEY_FLAG_INSTANTIATED)
and test_bit(KEY_FLAG_NEGATIVE) races in stable 4.1?

	-ss
