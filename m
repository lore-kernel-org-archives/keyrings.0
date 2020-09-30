From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 30 Sep 2020 21:49:44 +0000
Subject: Re: [PATCH 1/2] certs: Move load_system_certificate_list to a common function
Message-Id: <20200930214944.GA67803@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200930201508.35113-1-eric.snowberg@oracle.com>
 <20200930201508.35113-2-eric.snowberg@oracle.com>
 <20200930210254.GB65339@linux.intel.com>
 <9E194595-5A19-42F8-9657-7FB36DE59F16@oracle.com>
In-Reply-To: <9E194595-5A19-42F8-9657-7FB36DE59F16@oracle.com>
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: dhowells@redhat.com, dwmw2@infradead.org, masahiroy@kernel.org, michal.lkml@markovi.net, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org

On Wed, Sep 30, 2020 at 03:15:10PM -0600, Eric Snowberg wrote:
> 
> > On Sep 30, 2020, at 3:02 PM, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > 
> > On Wed, Sep 30, 2020 at 04:15:07PM -0400, Eric Snowberg wrote:
> >> Move functionality within load_system_certificate_list to a common
> >> function, so it can be reused in the future.
> >> 
> >> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> > 
> > I rather think now rather than the future. I think this should be part
> > of a patch set where the re-use actually happens.
> 
> load_certificate_list is being used in the second patch in the series [1].
> It uses the now common code, to load the revocation certificates, just like
> the system certificates are being loaded in this patch.

Ugh, better to get some sleep. Double checked 2/2 and ack still holds.
Sorry about this.

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
