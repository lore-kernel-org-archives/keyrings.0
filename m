From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 09 Jan 2020 19:38:37 +0000
Subject: Re: [PATCH] IMA: fix measuring early boot asymmetric keys
Message-Id: <1578598717.5147.71.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20200109175046.4024-1-nramas@linux.microsoft.com>
In-Reply-To: <20200109175046.4024-1-nramas@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, James.Bottomley@HansenPartnership.com, linux-integrity@vger.kernel.org
Cc: dhowells@redhat.com, arnd@arndb.de, matthewgarrett@google.com, sashal@kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Thu, 2020-01-09 at 09:50 -0800, Lakshmi Ramasubramanian wrote:

> This patch uses this new config CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
> to declare the early boot key measurement functions.

Thanks!  I've squashed this patch with "4217fbe396c4 IMA: Define
workqueue for early boot key measurements".

Mimi
