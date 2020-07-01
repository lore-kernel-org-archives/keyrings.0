From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date: Wed, 01 Jul 2020 12:49:29 +0000
Subject: Re: INFO: task hung in request_key_tag
Message-Id: <e34e7b99-221f-661b-a299-6cdc35760545@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <000000000000961dea05a95c9558@google.com>
 <728915db-592b-997f-6970-464cc59441d7@i-love.sakura.ne.jp>
 <20200701122030.GP4332@42.do-not-panic.com>
In-Reply-To: <20200701122030.GP4332@42.do-not-panic.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Naresh Kamboju <naresh.kamboju@linaro.org>, Herbert Xu <herbert@gondor.apana.org.au>, Christoph Hellwig <hch@infradead.org>
Cc: syzbot <syzbot+46c77dc7e98c732de754@syzkaller.appspotmail.com>, dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, serge@hallyn.com, syzkaller-bugs@googlegroups.com

On 2020/07/01 21:20, Luis Chamberlain wrote:
> On Wed, Jul 01, 2020 at 07:04:15PM +0900, Tetsuo Handa wrote:
>> I suspect commit 9e9b47d6bbe9df65 ("umh: fix processed error when UMH_WAIT_PROC is used").
>> Maybe the change in kernel/umh.c and/or security/keys/request_key.c made by that commit is
>> affecting call_usermodehelper_keys() = 0 case when complete_request_key() is called.
> 
> That patch has been dropped for now due to another reported issue
> bisected to it and even though we have not root caused that issue [0].
> 
> It would be good to have a reproducer for this reported issue as well,

Reproducer is not available yet.
But at least this patch is changing the behavior of

  call_usermodehelper_keys() = 0 && (test_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags) || key_validate(key) < 0)

case from key_negate_and_link() to key_revoke() in complete_request_key().
Since test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags) might be called from
key_reject_and_link() from key_negate_and_link(), this change might be the cause of
this hung task report.
