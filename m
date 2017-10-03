From: David Howells <dhowells@redhat.com>
Date: Tue, 03 Oct 2017 09:06:02 +0000
Subject: Re: [PATCH 1/3] crypto: dh_helper - return unsigned int for dh_data_size()
Message-Id: <22466.1507021562@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170929092106.24276-1-tudor.ambarus@microchip.com>
In-Reply-To: <20170929092106.24276-1-tudor.ambarus@microchip.com>
To: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: dhowells@redhat.com, herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, keyrings@vger.kernel.org

Tudor Ambarus <tudor.ambarus@microchip.com> wrote:

> -static inline int dh_data_size(const struct dh *p)
> +static inline unsigned int dh_data_size(const struct dh *p)
>  {
>  	return p->key_size + p->p_size + p->g_size;
>  }

If this is a problem, do you need to do range checking?

David
