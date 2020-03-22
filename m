From: Waiman Long <longman@redhat.com>
Date: Sun, 22 Mar 2020 00:46:33 +0000
Subject: Re: [PATCH v7 2/2] KEYS: Avoid false positive ENOMEM error on key read
Message-Id: <03c0c59e-a84b-bd75-6b3f-7f6467d806e2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200321184932.16579-1-longman@redhat.com>
 <20200321184932.16579-3-longman@redhat.com>
 <e3d7a227-8915-5c00-cd34-fe2db7fc7121@I-love.SAKURA.ne.jp>
In-Reply-To: <e3d7a227-8915-5c00-cd34-fe2db7fc7121@I-love.SAKURA.ne.jp>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, netdev@vger.kernel.org, linux-afs@lists.infradead.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

On 3/21/20 8:31 PM, Tetsuo Handa wrote:
> On 2020/03/22 3:49, Waiman Long wrote:
>> +	do {
>> +		if (ret > key_data_len) {
>> +			if (unlikely(key_data))
>> +				__kvzfree(key_data, key_data_len);
>> +			key_data_len = ret;
>> +			continue;	/* Allocate buffer */
> Excuse me, but "continue;" inside "do { ... } while (0);" means "break;"
> because "while (0)" is evaluated before continuing the loop.

You are right. My mistake. Will send out a new one for patch 2.

-Longman
