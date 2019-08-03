From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Sat, 03 Aug 2019 14:44:37 +0000
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or deactivated
Message-Id: <aff3502c598fb76a1517795edaacd8c8ea330051.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
         <20190711194811.rfsohbfc3a7carpa@linux.intel.com>
         <b4454a78-1f1b-cc75-114a-99926e097b05@huawei.com>
         <20190801163215.mfkagoafkxscesne@linux.intel.com>
         <e50c4cfa-1f0c-6f4d-1910-010a8d874393@huawei.com>
         <20190802142721.GA26616@elm>
         <20190802194226.oiztvme5klkmw6fh@linux.intel.com>
         <20190802202343.GE26616@elm>
In-Reply-To: <20190802202343.GE26616@elm>
To: Tyler Hicks <tyhicks@canonical.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, jejb@linux.ibm.com, zohar@linux.ibm.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com, nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com

On Fri, 2019-08-02 at 15:23 -0500, Tyler Hicks wrote:
> That wasn't the conclusion that I came to. I prefer Robert's proposed
> change to trusted.ko.
> 
> How do you propose that this be fixed in eCryptfs?
> 
> Removing encrypted_key support from eCryptfs is the only way that I can
> see to fix the bug in eCryptfs. That support has been there since 2011.
> I'm not sure of the number of users that would be broken by removing
> encrypted_key support. I don't think the number is high but I can't say
> that confidently.

Looking at the documentation [1] it is stated that

"Encrypted keys do not depend on a TPM, and are faster, as they use AES
for encryption/decryption."

Why would you need to remove support for encrypted keys? Isn't it a
regression in encrypted keys to hard depend on trusted keys given
what the documentation says?

> Roberto, what was your use case when you added encrypted_key support to
> eCryptfs back then? Are you aware of any users of eCryptfs +
> encrypted_keys?
> 
> Jarkko, removing a long-standing feature is potentially more disruptive
> to users than adding a workaround to trusted.ko which already requires a
> similar workaround. I don't think that I agree with you on the proper
> fix here.

There is nothing to disagree or agree. I just try to get the picture
since ecryptfs is relatively alien to me.

[1] https://www.kernel.org/doc/html/v4.13/security/keys/trusted-encrypted.html

/Jarkko
