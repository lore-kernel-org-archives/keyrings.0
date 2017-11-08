From: David Howells <dhowells@redhat.com>
Date: Wed, 08 Nov 2017 12:50:17 +0000
Subject: Re: [PATCH v2] lib/mpi: call cond_resched() from mpi_powm() loop
Message-Id: <25888.1510145417@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171107221527.98433-1-ebiggers3@gmail.com>
In-Reply-To: <20171107221527.98433-1-ebiggers3@gmail.com>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: dhowells@redhat.com, linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, Tudor-Dan Ambarus <tudor.ambarus@microchip.com>, Mat Martineau <mathew.j.martineau@linux.intel.com>, Salvatore Benedetto <salvatore.benedetto@intel.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>, stable@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> On a non-preemptible kernel, if KEYCTL_DH_COMPUTE is called with the
> largest permitted inputs (16384 bits), the kernel spends 10+ seconds
> doing modular exponentiation in mpi_powm() without rescheduling.  If all
> threads do it, it locks up the system.  Moreover, it can cause
> rcu_sched-stall warnings.

Do you want this to go in immediately, or I should I push it to James for the
next merge window?

David
