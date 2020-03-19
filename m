From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 19 Mar 2020 19:46:50 +0000
Subject: Re: [PATCH v5 2/2] KEYS: Avoid false positive ENOMEM error on key read
Message-Id: <20200319194650.GA24804@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200318221457.1330-1-longman@redhat.com>
 <20200318221457.1330-3-longman@redhat.com>
In-Reply-To: <20200318221457.1330-3-longman@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, netdev@vger.kernel.org, linux-afs@lists.infradead.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

On Wed, Mar 18, 2020 at 06:14:57PM -0400, Waiman Long wrote:
> +			 * It is possible, though unlikely, that the key
> +			 * changes in between the up_read->down_read period.
> +			 * If the key becomes longer, we will have to
> +			 * allocate a larger buffer and redo the key read
> +			 * again.
> +			 */
> +			if (!tmpbuf || unlikely(ret > tmpbuflen)) {

Shouldn't you check that tmpbuflen stays below buflen (why else
you had made copy of buflen otherwise)?

/Jarkko
