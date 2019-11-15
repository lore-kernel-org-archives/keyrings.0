From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 15 Nov 2019 13:14:39 +0000
Subject: Re: [PATCH v7 3/5] KEYS: Call the IMA hook to measure keys
Message-Id: <1573823679.4793.121.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191114031202.18012-1-nramas@linux.microsoft.com>
         <20191114031202.18012-4-nramas@linux.microsoft.com>
         <1573743267.4793.43.camel@linux.ibm.com>
         <24262d82-c90b-b64d-f237-9ef038f38d0e@linux.microsoft.com>
In-Reply-To: <24262d82-c90b-b64d-f237-9ef038f38d0e@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2019-11-14 at 10:24 -0800, Lakshmi Ramasubramanian wrote:
> On 11/14/2019 6:54 AM, Mimi Zohar wrote:
> > With this patch, keys are now being measured.  With the boot command
> > line, we can verify the measurement entry against /proc/cmdline.  How
> > can the key measurement entry be verified?  Please include that
> > information, here, in this patch description.
> 
> Glad you could verify measurement of keys. Thanks a lot for trying it.
> 
> Will add information on testing\validating the feature.

Thank you.

> 
> > Also, can the key data, now included in the measurement list, be used
> > to verify signatures in the ima-sig or ima-modsig templates?  Is there
> > a way of correlating a signature with a key?  Perhaps include a
> > kselftest as an example.
> 
> I am not familiar with kselftest. Will take a look and see if it'd be 
> possible to correlate a signature with a key.

I'd like the measurement list to be self contained, allowing a
regression test, for example, to walk the measurement list, verifying
the file signatures stored in the measurement list based on the key
measurement(s).

It isn't so much about Kselftest, but implementing a regression test
(eg. Kselftest, LTP, ima-evm-utils, ...) as a PoC, in order to know
that the key measurement contains everything needed to identify the
key (eg. keyid, certificate serial number, ...) and verify file
signatures.

Mimi
