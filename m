From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 16 Jan 2020 13:10:32 +0000
Subject: Re: [PATCH] IMA: inconsistent lock state in ima_process_queued_keys
Message-Id: <1579180232.5857.23.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200116031342.3418-1-nramas@linux.microsoft.com>
In-Reply-To: <20200116031342.3418-1-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, dvyukov@google.com, James.Bottomley@HansenPartnership.com, arnd@arndb.de, linux-integrity@vger.kernel.org
Cc: dhowells@redhat.com, sashal@kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org

On Wed, 2020-01-15 at 19:13 -0800, Lakshmi Ramasubramanian wrote:
> ima_queued_keys() is called from a non-interrupt context, but
> ima_process_queued_keys() may be called from both an interrupt
> context (ima_timer_handler) and non-interrupt context
> (ima_update_policy). Since the spinlock named ima_keys_lock is used
> in both ima_queued_keys() and ima_process_queued_keys(),
> irq version of the spinlock macros, spin_lock_irqsave() and
> spin_unlock_irqrestore(), should be used[1].
> 
> This patch fixes the "inconsistent lock state" issue caused by
> using the non-irq version of the spinlock macros in ima_queue_key()
> and ima_process_queued_keys().
> 
> [1] Documentation/locking/spinlocks.rst
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Reported-by: syzbot <syzbot+a4a503d7f37292ae1664@syzkaller.appspotmail.com>
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Fixes: 8f5d2d06f217 ("IMA: Defined timer to free queued keys")
> Fixes: 9fb38e76b5f1 ("IMA: Define workqueue for early boot key measurements")

Thanks!  This patch is now queued in next-integrity-testing.

Mimi
