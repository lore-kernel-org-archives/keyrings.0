From: Eric Snowberg <eric.snowberg@oracle.com>
Date: Wed, 30 Sep 2020 21:15:10 +0000
Subject: Re: [PATCH 1/2] certs: Move load_system_certificate_list to a common function
Message-Id: <9E194595-5A19-42F8-9657-7FB36DE59F16@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200930201508.35113-1-eric.snowberg@oracle.com>
 <20200930201508.35113-2-eric.snowberg@oracle.com>
 <20200930210254.GB65339@linux.intel.com>
In-Reply-To: <20200930210254.GB65339@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: dhowells@redhat.com, dwmw2@infradead.org, masahiroy@kernel.org, michal.lkml@markovi.net, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, Eric Snowberg <eric.snowberg@oracle.com>


> On Sep 30, 2020, at 3:02 PM, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> On Wed, Sep 30, 2020 at 04:15:07PM -0400, Eric Snowberg wrote:
>> Move functionality within load_system_certificate_list to a common
>> function, so it can be reused in the future.
>> 
>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> 
> I rather think now rather than the future. I think this should be part
> of a patch set where the re-use actually happens.

load_certificate_list is being used in the second patch in the series [1].
It uses the now common code, to load the revocation certificates, just like
the system certificates are being loaded in this patch.


> Without that context, I rather not say anything about this patch.
> Neither an issue for me if it gets applied. This is just a guideline
> that I follow (in order to manage this chaos).
> 
> Looking at the code change, I do not see anything strikingly wrong in
> it.

Thanks

[1] https://lore.kernel.org/patchwork/patch/1315486/
