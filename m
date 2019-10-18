From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Fri, 18 Oct 2019 20:38:12 +0000
Subject: Re: [PATCH v0] KEYS: Security LSM Hook for key_create_or_update
Message-Id: <48a4db30-853b-ef6b-9d35-77ae0450b65d@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191018195328.6704-1-nramas@linux.microsoft.com>
 <e5ffe76e-ff9f-7542-2ff7-3ede4f911c2a@schaufler-ca.com>
In-Reply-To: <e5ffe76e-ff9f-7542-2ff7-3ede4f911c2a@schaufler-ca.com>
To: Casey Schaufler <casey@schaufler-ca.com>, zohar@linux.ibm.com, dhowells@redhat.com, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, sashal@kernel.org, jamorris@linux.microsoft.com
Cc: msft-linux-kernel@linux.microsoft.com, prsriva@linux.microsoft.com

On 10/18/19 1:25 PM, Casey Schaufler wrote:

>> Problem Statement:
>> key_create_or_update function currently does not have
>> a security LSM hook. The hook is needed to allow security
>> subsystems to use key create or update information.
> 
> What security module(s) do you expect to use this?

SELinux is one that I can think of - it has hooks for key_alloc, 
key_free, etc. But does not have one for key_create_or_update.
> IMA is not a Linux Security Module.

Agree. But ima utilizes LSM to hook into system operations (such as 
read_file given below).
int security_kernel_post_read_file(struct file *file, char *buf,
                                    loff_t size,
				   enum kernel_read_file_id id)
{
	int ret;

	ret = call_int_hook(kernel_post_read_file, 0, file,
                             buf, size, id);
	if (ret)
		return ret;
	return ima_post_read_file(file, buf, size, id);
}

I am currently working on an ima function to measure keys. The change 
set I have submitted today is in preparation for that.
> You don't have a security module that provides this hook.
> We don't accept interfaces without users.

Like I have mentioned above, that change in ima will be submitted for 
review shortly.

If you have suggestions for a better way to hook into key create\update 
that ima can use to measure keys, I'll be happy to investigate that.

thanks,
  -lakshmi
