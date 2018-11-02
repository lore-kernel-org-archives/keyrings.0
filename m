From: David Howells <dhowells@redhat.com>
Date: Fri, 02 Nov 2018 14:45:45 +0000
Subject: Re: [PATCH v2 5/7] keyctl_dh_compute_kdf: use a void* for opaque data
Message-Id: <11357.1541169945@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180927131436.23328-6-mathstuf@gmail.com>
In-Reply-To: <20180927131436.23328-6-mathstuf@gmail.com>
To: keyrings@vger.kernel.org

Ben Boeckel <mathstuf@gmail.com> wrote:

>  struct keyctl_kdf_params {
>  	const char *hashname;
> -	const char *otherinfo;
> +	const void *otherinfo;
>  	uint32_t otherinfolen;
>  	uint32_t __spare[8];
>  };

Hmmm...  This no longer matches the definition in the kernel's UAPI.

Also note that this *is* a significant change in C++.

David
