From: Ben Boeckel <mathstuf@gmail.com>
Date: Fri, 02 Nov 2018 16:05:40 +0000
Subject: Re: [PATCH v2 4/7] keyctl_dh_compute_kdf: const-ify input parameters
Message-Id: <20181102160540.GB17276@rotor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180927131436.23328-5-mathstuf@gmail.com>
In-Reply-To: <20180927131436.23328-5-mathstuf@gmail.com>
To: keyrings@vger.kernel.org

On Fri, Nov 02, 2018 at 15:08:56 +0000, David Howells wrote:
> Actually, that's potentially not okay.  If some code out there has:
> 
> 	struct keyctl_kdf_params p = {
> 		.hashname = "foo"
> 	};
> 
> 	...
> 
> 	char *h = p.hashname;
> 
> that will no longer compile, so I'm not going to apply this patch for the
> moment.

What code is using a non-released version of libkeyutils and expects it
to work as-is when the relevant code does land? These patches are not
against `master`, but `next` (sorry, should have mentioned that or made
it clearer).

--Ben
