From: David Howells <dhowells@redhat.com>
Date: Fri, 02 Nov 2018 16:20:40 +0000
Subject: Re: [PATCH v2 4/7] keyctl_dh_compute_kdf: const-ify input parameters
Message-Id: <19096.1541175640@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180927131436.23328-5-mathstuf@gmail.com>
In-Reply-To: <20180927131436.23328-5-mathstuf@gmail.com>
To: keyrings@vger.kernel.org

Ben Boeckel <mathstuf@gmail.com> wrote:

> What code is using a non-released version of libkeyutils and expects it
> to work as-is when the relevant code does land?

Ummm...

	struct keyctl_kdf_params {
		char *hashname;
		char *otherinfo;
		uint32_t otherinfolen;
		uint32_t __spare[8];
	};

is in v1.5.11 as released in August.

David
