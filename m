From: David Howells <dhowells@redhat.com>
Date: Fri, 02 Nov 2018 15:08:56 +0000
Subject: Re: [PATCH v2 4/7] keyctl_dh_compute_kdf: const-ify input parameters
Message-Id: <12983.1541171336@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180927131436.23328-5-mathstuf@gmail.com>
In-Reply-To: <20180927131436.23328-5-mathstuf@gmail.com>
To: keyrings@vger.kernel.org

Ben Boeckel <mathstuf@gmail.com> wrote:

>  struct keyctl_kdf_params {
> -	char *hashname;
> -	char *otherinfo;
> +	const char *hashname;
> +	const char *otherinfo;
>  	uint32_t otherinfolen;
>  	uint32_t __spare[8];
>  };

Actually, that's potentially not okay.  If some code out there has:

	struct keyctl_kdf_params p = {
		.hashname = "foo"
	};

	...

	char *h = p.hashname;

that will no longer compile, so I'm not going to apply this patch for the
moment.

David
