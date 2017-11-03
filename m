From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 03 Nov 2017 13:04:28 +0000
Subject: Re: [LTP] [PATCH v2] syscalls/request_key03: new test for key instantiation races
Message-Id: <20171103130428.GA22844@rei>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Hi!
When I run the test as an ordinary user I got EDQUOT from add_key() from
time to time. So we either have to add .needs_root = 1 so that quotas
does not apply or change the test to ignore the EDQUOT as well while we
are adding the key.

Otherwise the test is OK.

-- 
Cyril Hrubis
chrubis@suse.cz
