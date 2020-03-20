From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 20 Mar 2020 22:21:13 +0000
Subject: Re: [PATCH v6 2/2] KEYS: Avoid false positive ENOMEM error on key read
Message-Id: <20200320222113.GB5284@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200320191903.19494-1-longman@redhat.com>
 <20200320191903.19494-3-longman@redhat.com>
 <20200320221918.GA5284@linux.intel.com>
In-Reply-To: <20200320221918.GA5284@linux.intel.com>
To: Waiman Long <longman@redhat.com>
Cc: David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, netdev@vger.kernel.org, linux-afs@lists.infradead.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

On Sat, Mar 21, 2020 at 12:19:27AM +0200, Jarkko Sakkinen wrote:
> Would move this label before condition instead of jumping inside the
> nested block since it will always evaluate correctly.
> 
> To this version haven't really gotten why you don't use a legit loop
> construct but instead jump from one random nested location to another
> random nested location? This construct will be somewhat nasty to
> maintain. The construct is weird enough that you should have rather
> good explanation in the long description why such a mess.

What I'm saying that if I fix a bug, the first version of the fix
would probably look something like this is right now. They I think
how to write it right. We don't want fixes that just happen to work.
Right now I'm worried to take this in since I'm not confident that
I haven't some possible corner case, or might still have gotten
something just plain wrong.

/Jarkko
