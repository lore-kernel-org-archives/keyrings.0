From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 14 Nov 2019 18:18:55 +0000
Subject: Re: [PATCH v7 4/5] IMA: Add support to limit measuring keys
Message-Id: <1deec85d-78b1-0cf2-ec2c-7dacaa2c3672@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191114031202.18012-1-nramas@linux.microsoft.com>
 <20191114031202.18012-5-nramas@linux.microsoft.com>
 <1573742237.4793.30.camel@linux.ibm.com>
In-Reply-To: <1573742237.4793.30.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/14/2019 6:37 AM, Mimi Zohar wrote:
> Keyrings may be created by userspace with any name (e.g. foo, foobar,
> ...).  A keyring name might be a subset of another keyring name.  For
> example, with the policy "keyrings=foobar", keys being loaded on "foo"
> would also be measured.  Using strstr() will not achieve what is
> needed.
> 
> Mimi

Very good catch - I missed that :(

Will fix and send an update.

thanks,
  -lakshmi
