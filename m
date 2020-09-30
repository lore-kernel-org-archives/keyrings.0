From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 30 Sep 2020 20:56:31 +0000
Subject: Re: [PATCH 2/2] certs: Add ability to preload revocation certs
Message-Id: <20200930205631.GA65339@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200930201508.35113-1-eric.snowberg@oracle.com>
 <20200930201508.35113-3-eric.snowberg@oracle.com>
In-Reply-To: <20200930201508.35113-3-eric.snowberg@oracle.com>
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: dhowells@redhat.com, dwmw2@infradead.org, masahiroy@kernel.org, michal.lkml@markovi.net, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org

On Wed, Sep 30, 2020 at 04:15:08PM -0400, Eric Snowberg wrote:
> Add a new Kconfig option called SYSTEM_REVOCATION_KEYS. If set,
> this option should be the filename of a PEM-formated file containing
> X.509 certificates to be included in the default blacklist keyring.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
