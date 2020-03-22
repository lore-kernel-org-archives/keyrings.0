From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sun, 22 Mar 2020 00:31:21 +0000
Subject: Re: [PATCH v7 2/2] KEYS: Avoid false positive ENOMEM error on key read
Message-Id: <e3d7a227-8915-5c00-cd34-fe2db7fc7121@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200321184932.16579-1-longman@redhat.com>
 <20200321184932.16579-3-longman@redhat.com>
In-Reply-To: <20200321184932.16579-3-longman@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, netdev@vger.kernel.org, linux-afs@lists.infradead.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

On 2020/03/22 3:49, Waiman Long wrote:
> +	do {

> +		if (ret > key_data_len) {
> +			if (unlikely(key_data))
> +				__kvzfree(key_data, key_data_len);
> +			key_data_len = ret;
> +			continue;	/* Allocate buffer */

Excuse me, but "continue;" inside "do { ... } while (0);" means "break;"
because "while (0)" is evaluated before continuing the loop.

----------
#include <stdio.h>

int main(int argc, char *argv[])
{
        do {
                printf("step 1\n");
                if (1) {
                        printf("step 2\n");
                        continue;
                }
                printf("step 3\n");
        } while (0);
        printf("step 4\n");
        return 0;
}
----------

----------
step 1
step 2
step 4
----------

> +		}

> +	} while (0);
