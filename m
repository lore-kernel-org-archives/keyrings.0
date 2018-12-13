From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Thu, 13 Dec 2018 00:17:08 +0000
Subject: Re: [PATCH v2 2/7] integrity: Load certs to the platform keyring
Message-Id: <87zhtae0vv.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20181208202705.18673-1-nayna@linux.ibm.com> <20181208202705.18673-3-nayna@linux.ibm.com>
In-Reply-To: <20181208202705.18673-3-nayna@linux.ibm.com>
To: Nayna Jain <nayna@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, dhowells@redhat.com, jforbes@redhat.com, seth.forshee@canonical.com, kexec@lists.infradead.org, keyrings@vger.kernel.org, vgoyal@redhat.com, ebiederm@xmission.com, mpe@ellerman.id.au


Nayna Jain <nayna@linux.ibm.com> writes:

> The patch refactors integrity_load_x509(), making it a wrapper for a new
> function named integrity_add_key(). This patch also defines a new
> function named integrity_load_cert() for loading the platform keys.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> ---
>  security/integrity/digsig.c                        | 71 ++++++++++++++--------
>  security/integrity/integrity.h                     | 20 ++++++
>  .../integrity/platform_certs/platform_keyring.c    | 23 +++++++
>  3 files changed, 90 insertions(+), 24 deletions(-)

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
