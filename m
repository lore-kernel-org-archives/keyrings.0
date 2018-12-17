From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 17 Dec 2018 18:12:44 +0000
Subject: [PATCH RESEND] KEYS: fix parsing invalid pkey info string
Message-Id: <20181217181244.220052-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20181128232019.GC131170@gmail.com>
In-Reply-To: <20181128232019.GC131170@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com

From: Eric Biggers <ebiggers@google.com>

We need to check the return value of match_token() for Opt_err (-1)
before doing anything with it.

Reported-by: syzbot+a22e0dc07567662c50bc@syzkaller.appspotmail.com
Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---

Hi Linus, please consider applying this patch.  It's been ignored by the
keyrings maintainer for a month and a half with multiple reminders.  It
fixes an easily reachable stack corruption in the new keyctl operations
that were added in v4.20.  It was immediately reached by syzbot even
without any definitions for the new keyctls yet.

 security/keys/keyctl_pkey.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 783978842f13a..987fac8051d70 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -50,6 +50,8 @@ static int keyctl_pkey_params_parse(struct kernel_pkey_params *params)
 		if (*p = '\0' || *p = ' ' || *p = '\t')
 			continue;
 		token = match_token(p, param_keys, args);
+		if (token = Opt_err)
+			return -EINVAL;
 		if (__test_and_set_bit(token, &token_mask))
 			return -EINVAL;
 		q = args[0].from;
-- 
2.20.0.405.gbc1bbc6f85-goog
