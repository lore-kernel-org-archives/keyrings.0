From: David Miller <davem@davemloft.net>
Date: Thu, 26 Mar 2020 02:30:56 +0000
Subject: Re: [PATCH v8 0/2] KEYS: Read keys to internal buffer & then copy to userspace
Message-Id: <20200325.193056.1153970692429454819.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200322011125.24327-1-longman@redhat.com>
In-Reply-To: <20200322011125.24327-1-longman@redhat.com>
To: longman@redhat.com
Cc: dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, kuba@kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, netdev@vger.kernel.org, linux-afs@lists.infradead.org, sumit.garg@linaro.org, jsnitsel@redhat.com, roberto.sassu@huawei.com, ebiggers@google.com, crecklin@redhat.com

From: Waiman Long <longman@redhat.com>
Date: Sat, 21 Mar 2020 21:11:23 -0400

> The current security key read methods are called with the key semaphore
> held.  The methods then copy out the key data to userspace which is
> subjected to page fault and may acquire the mmap semaphore. That can
> result in circular lock dependency and hence a chance to get into
> deadlock.
> 
> To avoid such a deadlock, an internal buffer is now allocated for getting
> out the necessary data first. After releasing the key semaphore, the
> key data are then copied out to userspace sidestepping the circular
> lock dependency.
> 
> The keyutils test suite was run and the test passed with these patchset
> applied without any falure.

Who will integrate these changes?
