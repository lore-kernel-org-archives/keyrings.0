From: David Howells <dhowells@redhat.com>
Date: Mon, 12 Nov 2018 12:35:14 +0000
Subject: Re: [RFC][PATCH 05/12] PGPLIB: Signature parser
Message-Id: <19466.1542026114@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20181112102423.30415-6-roberto.sassu@huawei.com> <20181112102423.30415-1-roberto.sassu@huawei.com>
In-Reply-To: <20181112102423.30415-6-roberto.sassu@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au, davem@davemloft.net, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com

Roberto Sassu <roberto.sassu@huawei.com> wrote:

> -	pr_devel("datalen=%zu size=%zu", datalen, size);
> +	pr_devel("datalen=%zu size=%zu\n", datalen, size);

This needs rolling back into a previous patch.

> +	if ((int)size < 0)

size > INT_MAX

David
