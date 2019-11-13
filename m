From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Wed, 13 Nov 2019 20:52:46 +0000
Subject: Re: [PATCH v6 2/3] IMA: Define an IMA hook to measure keys
Message-Id: <8eba665e-637c-d341-c77d-4f2645d3b246@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191113184658.2862-1-nramas@linux.microsoft.com>
 <20191113184658.2862-3-nramas@linux.microsoft.com>
 <1573675761.4843.13.camel@linux.ibm.com>
In-Reply-To: <1573675761.4843.13.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/13/19 12:09 PM, Mimi Zohar wrote:
>
> All that is is needed is the key and public_key structures, which are
> defined in include/linux/keys.h and include/crypto/public_key.h.  If
> the keys subsystem is disabled, then the new IMA hook won't be called.
>   There's no need for a new Kconfig option or a new file.
> 
> Please move the hook to just after ima_kexec_cmdline().
> 
> Mimi

Yes - IMA hook won't be called when KEYS subsystem is disabled.

But, build dependency is breaking since "struct key" is not defined 
without CONFIG_KEYS.

Sasha was able to craft a .config that enabled IMA without enabling KEYS 
and found the build break.

Please see the build output he'd shared.

***********************************************************************

In file included from security/integrity/ima/ima.h:25,
                 from security/integrity/ima/ima_fs.c:26:
./include/keys/asymmetric-type.h: In function ‘asymmetric_key_ids’:
./include/keys/asymmetric-type.h:72:12: error: dereferencing pointer to 
incomplete type ‘const struct key’
  return key->payload.data[asym_key_ids];
            ^~
make[3]: *** [scripts/Makefile.build:266: 
security/integrity/ima/ima_fs.o] Error 1
make[3]: *** Waiting for unfinished jobs....
In file included from security/integrity/ima/ima.h:25,
                 from security/integrity/ima/ima_queue.c:22:
./include/keys/asymmetric-type.h: In function ‘asymmetric_key_ids’:
./include/keys/asymmetric-type.h:72:12: error: dereferencing pointer to 
incomplete type ‘const struct key’
  return key->payload.data[asym_key_ids];

***********************************************************************

thanks,
  -lakshmi
