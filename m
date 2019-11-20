From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Wed, 20 Nov 2019 23:40:14 +0000
Subject: Re: [PATCH v8 2/5] IMA: Define an IMA hook to measure keys
Message-Id: <98eeec95-cc19-2900-b96e-eadaac1b4a68@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191118223818.3353-1-nramas@linux.microsoft.com>
 <20191118223818.3353-3-nramas@linux.microsoft.com>
 <ED63593E-BE9B-40B7-B7FD-9DE772DC2EB1@oracle.com>
In-Reply-To: <ED63593E-BE9B-40B7-B7FD-9DE772DC2EB1@oracle.com>
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: zohar@linux.ibm.com, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On 11/20/2019 3:28 PM, Eric Snowberg wrote:
Hi Eric,

> 
> I’m interested in using this patch series, however I get the following on every boot:

> [    1.222749] Call Trace:
> [    1.223344]  ? crypto_destroy_tfm+0x5f/0xb0
> [    1.224315]  ima_get_action+0x2c/0x30
> [    1.225148]  process_buffer_measurement+0x1da/0x230
> [    1.226306]  ima_post_key_create_or_update+0x3b/0x40

This is happening because IMA is not yet initialized when the IMA hook 
is called.

I had the following check in process_buffer_measurement() as part of my 
patch, but removed it since it is being upstreamed separately (by Mimi)

  if (!ima_policy_flag)
  	return;

Until this change is in, please add the above line locally on entry to 
process_buffer_measurement() to get around the issue.

thanks,
  -lakshmi
