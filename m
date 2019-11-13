From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Wed, 13 Nov 2019 22:01:11 +0000
Subject: Re: [PATCH v6 2/3] IMA: Define an IMA hook to measure keys
Message-Id: <1e40a6c5-13b9-38e2-d855-7c5334922dec@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191113184658.2862-1-nramas@linux.microsoft.com>
 <20191113184658.2862-3-nramas@linux.microsoft.com>
 <1573675761.4843.13.camel@linux.ibm.com>
 <8eba665e-637c-d341-c77d-4f2645d3b246@linux.microsoft.com>
 <1573679903.4517.5.camel@linux.ibm.com>
In-Reply-To: <1573679903.4517.5.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/13/19 1:18 PM, Mimi Zohar wrote:

> Yes, thanks for pointing out the "#ifdef CONFIG_KEYS" in keys.h.  A
> separate file is needed, as you pointed out, but still no need for a
> new Kconfig.  The ima/Makefile can be based on CONFIG_KEYS.
> 
> Mimi

Sure - i'll try it now and send an updated patch set.

thanks,
  -lakshmi
