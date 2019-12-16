From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Mon, 16 Dec 2019 21:52:26 +0000
Subject: Re: [PATCH v4 2/2] IMA: Call workqueue functions to measure queued keys
Message-Id: <f25b7299-1530-2e43-cdf4-2208c82fc768@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191213171827.28657-1-nramas@linux.microsoft.com>
 <20191213171827.28657-3-nramas@linux.microsoft.com>
 <1576257955.8504.20.camel@HansenPartnership.com>
 <39624b97-245c-ed05-27c5-588787aacc00@linux.microsoft.com>
 <1576423353.3343.3.camel@HansenPartnership.com>
 <1568ff14-316f-f2c4-84d4-7ca4c0a1936a@linux.microsoft.com>
 <1576479187.3784.1.camel@HansenPartnership.com>
 <8844a360-6d1e-1435-db7c-fd7739487168@linux.microsoft.com>
 <1576531022.3365.6.camel@HansenPartnership.com>
 <35a6c241-9a46-2657-51d1-0c04d32a9fae@linux.microsoft.com>
In-Reply-To: <35a6c241-9a46-2657-51d1-0c04d32a9fae@linux.microsoft.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On 12/16/2019 1:37 PM, Lakshmi Ramasubramanian wrote:
> 
> On 12/16/2019 1:17 PM, James Bottomley wrote:
>> On Mon, 2019-12-16 at 11:20 -0800, Lakshmi Ramasubramanian wrote:
>>>    => If the flag is false, mutex is taken and the flag is checked
>>> again. If the flag changed from false to true between the above two
>>> tests, that means another thread had raced to call
>>> ima_process_queued_keys() and has  processed the queued keys. So
>>> again, no further action is required.
>>
>> This is the problem: in the race case you may still be adding keys to
>> the queue after the other thread has processed it. Those keys won't get
>> processed because the flag is now false in the post check so the
>> current thread won't process them either.
>>
>> James
>>

Please keep in mind that ima_queue_key() returns a boolean indicating 
whether or not the key was queued. This flag is set inside the lock - 
please see the code snippet from ima_queue_key() below:

+	mutex_lock(&ima_keys_mutex);
+	if (!ima_process_keys) {
+		list_add_tail(&entry->list, &ima_keys);
+		queued = true;
+	}
+	mutex_unlock(&ima_keys_mutex);

If ima_process_keys had changed from false to true, ima_queue_key() will 
not queue the key and return false to ima_post_key_create_or_update().

Code snippet in ima_post_key_create_or_update():

+	if (!ima_process_keys)
+		queued = ima_queue_key(keyring, payload, payload_len);
+
+	if (queued)
+		return;

If the "queued" is false, ima_post_key_create_or_update() will process 
the key immediately.

  -lakshmi
