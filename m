From: David Howells <dhowells@redhat.com>
Date: Wed, 18 Mar 2020 15:14:24 +0000
Subject: Re: [PATCH v4 4/4] KEYS: Avoid false positive ENOMEM error on key read
Message-Id: <2866042.1584544464@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <e47bef56-9271-93e0-0e59-c77c253babea@redhat.com> <20200317194140.6031-5-longman@redhat.com> <20200317194140.6031-1-longman@redhat.com> <2832139.1584520054@warthog.procyon.org.uk>
In-Reply-To: <e47bef56-9271-93e0-0e59-c77c253babea@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: dhowells@redhat.com, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, netdev@vger.kernel.org, linux-afs@lists.infradead.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

Waiman Long <longman@redhat.com> wrote:

> Doing this is micro-optimization. As the keys subsystem is that
> performance critical, do we need to do that to save a cycle or two while
> making the code a bit harder to read?

It was more sort of a musing comment.  Feel free to ignore it.  kvfree()
doesn't do this.

David
