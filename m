From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 07 Jan 2020 22:51:52 +0000
Subject: Re: [PATCH 2/4] KEYS: Call the IMA hook to measure keys
Message-Id: <1578437512.5222.110.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20200107194350.3782-1-nramas@linux.microsoft.com>
         <20200107194350.3782-3-nramas@linux.microsoft.com>
In-Reply-To: <20200107194350.3782-3-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, James.Bottomley@HansenPartnership.com, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Tue, 2020-01-07 at 11:43 -0800, Lakshmi Ramasubramanian wrote:
> Call the IMA hook from key_create_or_update() function to measure
> the payload when a new key is created or an existing key is updated.
> 
> This patch adds the call to the IMA hook from key_create_or_update()
> function to measure the key on key create or update.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reported-by: kbuild test robot <lkp@intel.com> # ima_asymmetric_keys.c
> is built as a kernel module when it is actually not.
> Fixes: cb1aa3823c92 ("KEYS: Call the IMA hook to measure keys")

There are two ways of addressing a bug report.  One is by fixing the
original patch, while the other addresses the bug as a separate patch.
 If the fix is squashed into the original patch, the commit number
will change.  Only if the fix is a separate patch, would you include
the "Fixes" tag.

Mimi
