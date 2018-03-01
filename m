From: J Freyensee <why2jjj.linux@gmail.com>
Date: Thu, 01 Mar 2018 22:10:17 +0000
Subject: Re: [PATCH 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
Message-Id: <5d8921fb-f7e0-5498-99e2-d4d84aa597f3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
 <20180228195819.22231-4-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20180228195819.22231-4-jarkko.sakkinen@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>

.
.
.
I'm new to this area of the kernel, but I'm not getting these lines:

> +	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
> +	tpm_buf_destroy(&buf);
>   	if (rc <  0)
Why is this if() check not directly after the tpm_transmit_cmd() call 
that sets rc?  Is it correct you want to destroy buf regardless of the 
tpm_transmit_cmd() outcome?
>   		return rc;
> -
> -	if (be16_to_cpu(cmd.header.out.tag) = TPM2_ST_NO_SESSIONS)
> +	out = (struct tpm_output_header *)buf.data;

So buf has been destroyed, buf.data sill has something valid to assign 
to out?
> +	if (be16_to_cpu(out->tag) = TPM2_ST_NO_SESSIONS)
>   		chip->flags |= TPM_CHIP_FLAG_TPM2;
>   
>   	return 0;
Thanks,
Jay
