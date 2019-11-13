From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 13 Nov 2019 21:18:23 +0000
Subject: Re: [PATCH v6 2/3] IMA: Define an IMA hook to measure keys
Message-Id: <1573679903.4517.5.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191113184658.2862-1-nramas@linux.microsoft.com>
         <20191113184658.2862-3-nramas@linux.microsoft.com>
         <1573675761.4843.13.camel@linux.ibm.com>
         <8eba665e-637c-d341-c77d-4f2645d3b246@linux.microsoft.com>
In-Reply-To: <8eba665e-637c-d341-c77d-4f2645d3b246@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2019-11-13 at 12:52 -0800, Lakshmi Ramasubramanian wrote:
> On 11/13/19 12:09 PM, Mimi Zohar wrote:
> >
> > All that is is needed is the key and public_key structures, which are
> > defined in include/linux/keys.h and include/crypto/public_key.h.  If
> > the keys subsystem is disabled, then the new IMA hook won't be called.
> >   There's no need for a new Kconfig option or a new file.
> > 
> > Please move the hook to just after ima_kexec_cmdline().
> > 
> > Mimi
> 
> Yes - IMA hook won't be called when KEYS subsystem is disabled.
> 
> But, build dependency is breaking since "struct key" is not defined 
> without CONFIG_KEYS.
> 
> Sasha was able to craft a .config that enabled IMA without enabling KEYS 
> and found the build break.

Yes, thanks for pointing out the "#ifdef CONFIG_KEYS" in keys.h.  A
separate file is needed, as you pointed out, but still no need for a
new Kconfig.  The ima/Makefile can be based on CONFIG_KEYS.

Mimi
