From: Sachin Sant <sachinp@linux.vnet.ibm.com>
Date: Fri, 30 Aug 2019 10:44:03 +0000
Subject: Re: Oops (request_key_auth_describe) while running cve-2016-7042 from LTP
Message-Id: <C41D3A16-835C-421C-9059-AABB7273E664@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190830085646.14740-1-hdanton@sina.com>
In-Reply-To: <20190830085646.14740-1-hdanton@sina.com>
To: Hillf Danton <hdanton@sina.com>
Cc: dhowells@redhat.com, linuxppc-dev@ozlabs.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org



> On 30-Aug-2019, at 2:26 PM, Hillf Danton <hdanton@sina.com> wrote:
> 
> 
> On Fri, 30 Aug 2019 12:18:07 +0530 Sachin Sant wrote:
>> 
>> [ 8074.351033] BUG: Kernel NULL pointer dereference at 0x00000038
>> [ 8074.351046] Faulting instruction address: 0xc0000000004ddf30
>> [ 8074.351052] Oops: Kernel access of bad area, sig: 11 [#1]
>> [ 8074.351056] LE PAGE_SIZEdK MMU=Hash SMP NR_CPUS 48 NUMA pSeries
> 
> Add rcu gp.
> 
> --- a/security/keys/request_key_auth.c
> +++ b/security/keys/request_key_auth.c
> @@ -64,12 +64,19 @@ static int request_key_auth_instantiate(
> static void request_key_auth_describe(const struct key *key,
> 				      struct seq_file *m)
> {
> -	struct request_key_auth *rka = dereference_key_rcu(key);
> +	struct request_key_auth *rka;
> +
> +	rcu_read_lock();
> +	rka = dereference_key_rcu(key);
> +	if (!rka)
> +		goto out;
> 

Thanks for the patch. Works for me. Test ran fine without any problems.

Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>

Thanks
-Sachin
