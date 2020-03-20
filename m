From: David Howells <dhowells@redhat.com>
Date: Fri, 20 Mar 2020 08:20:19 +0000
Subject: Re: [PATCH v5 1/2] KEYS: Don't write out to userspace while holding key semaphore
Message-Id: <3251035.1584692419@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200318221457.1330-2-longman@redhat.com> <20200318221457.1330-1-longman@redhat.com>
In-Reply-To: <20200318221457.1330-2-longman@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: dhowells@redhat.com, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, netdev@vger.kernel.org, linux-afs@lists.infradead.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

Waiman Long <longman@redhat.com> wrote:

> +		if ((ret > 0) && (ret <= buflen)) {

That's a bit excessive on the bracketage, btw, but don't worry about it unless
you respin the patches.

David
