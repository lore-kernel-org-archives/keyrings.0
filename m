From: Denis Efremov <efremov@linux.com>
Date: Tue, 13 Aug 2019 06:57:59 +0000
Subject: Re: Bad file pattern in MAINTAINERS section 'KEYS-TRUSTED'
Message-Id: <7152d1c2-14bc-87ae-618b-830a1fa008b0@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190325212705.26837-1-joe@perches.com>
In-Reply-To: <20190325212705.26837-1-joe@perches.com>
To: linux-kernel@vger.kernel.org
Cc: Joe Perches <joe@perches.com>, James Bottomley <jejb@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, Denis Kenzior <denkenz@gmail.com>, efremov@linux.com

Hi All,

Initially, I've prepared a patch and only after found this discussion. So, please,
look at this patch no more than just a simple reminder that get_maintainers.pl
still emits this warning.

Thanks,
Denis

------------------------ >8 ------------------------
Subject: [PATCH] MAINTAINERS: keys: Update path to trusted.h

Update MAINTAINERS record to reflect that trusted.h
was moved to a different directory.

Cc: Denis Kenzior <denkenz@gmail.com>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org
Fixes: 22447981fc05 ("KEYS: Move trusted.h to include/keys [ver #2]")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d213e192626..eeeb4097d5bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8920,7 +8920,7 @@ S:	Supported
 F:	Documentation/security/keys/trusted-encrypted.rst
 F:	include/keys/trusted-type.h
 F:	security/keys/trusted.c
-F:	security/keys/trusted.h
+F:	include/keys/trusted.h
 
 KEYS/KEYRINGS:
 M:	David Howells <dhowells@redhat.com>
-- 
2.21.0
