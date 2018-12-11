From: James Morris <jmorris@namei.org>
Date: Tue, 11 Dec 2018 18:49:00 +0000
Subject: Re: [PATCH v2 6/7] efi: Allow the "db" UEFI variable to be suppressed
Message-Id: <alpine.LRH.2.21.1812120548480.11653@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20181208202705.18673-1-nayna@linux.ibm.com>
 <20181208202705.18673-7-nayna@linux.ibm.com>
In-Reply-To: <20181208202705.18673-7-nayna-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
To: Nayna Jain <nayna-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Cc: linux-efi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zohar-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, seth.forshee-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org, jforbes-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-integrity-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Josh Boyer <jwboyer-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On Sun, 9 Dec 2018, Nayna Jain wrote:

> From: Josh Boyer <jwboyer@fedoraproject.org>
> 
> If a user tells shim to not use the certs/hashes in the UEFI db variable
> for verification purposes, shim will set a UEFI variable called
> MokIgnoreDB. Have the uefi import code look for this and ignore the db
> variable if it is found.
> 
> Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: Nayna Jain <nayna@linux.ibm.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>
