From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 14 May 2020 23:43:04 +0000
Subject: Re: [PATCH v4 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
Message-Id: <b59e8ef4070f1aba31b4351910d6e819802eb551.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
 <1588758017-30426-3-git-send-email-sumit.garg@linaro.org>
 <ef2093f96eae7e9e6785f2c0ad00604d8adfd3be.camel@linux.intel.com>
 <CAFA6WYPr1iL-uJgSRu_61uv=2DhuEdDVdQLDuyPEOOK2jEgvyg@mail.gmail.com>
In-Reply-To: <CAFA6WYPr1iL-uJgSRu_61uv=2DhuEdDVdQLDuyPEOOK2jEgvyg@mail.gmail.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, op-tee@lists.trustedfirmware.org, Jonathan Corbet <corbet@lwn.net>, James Bottomley <jejb@linux.ibm.com>, Janne Karhunen <janne.karhunen@gmail.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, James Morris <jmorris@namei.org>, Mimi Zohar <zohar@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dhowells@redhat.com, linux-security-module@vger.kernel.org, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, Markus Wamser <Markus.Wamser@mixed-mode.de>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, Jens Wiklander <jens.wiklander@linaro.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Serge E.
 Hallyn" <serge@hallyn.com>

On Thu, 2020-05-14 at 12:57 +0530, Sumit Garg wrote:
> On Thu, 14 May 2020 at 05:58, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> > On Wed, 2020-05-06 at 15:10 +0530, Sumit Garg wrote:
> > > Add support for TEE based trusted keys where TEE provides the functionality
> > > to seal and unseal trusted keys using hardware unique key.
> > > 
> > > Refer to Documentation/tee.txt for detailed information about TEE.
> > > 
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > 
> > The implementation looks solid but how or who could possibly test this?
> > 
> > I do posses (personally, not from employer) bunch of ARM boards but my
> > TZ knowledge is somewhat limited (e.g. how can I get something running
> > in TZ).
> > 
> 
> Although, it should be fairly easy to test this implementation on an
> ARM board which supports OP-TEE. But since you are new to ARM
> TrustZone world, I would suggest you get used to OP-TEE on Qemu based
> setup. You could find pretty good documentation for this here [1] but
> for simplicity let me document steps here to test this trusted keys
> feature from scratch:
> 
> # Install prerequisites as mentioned here [2]
> 
> # Get the source code
> $ mkdir -p <optee-project>
> $ cd <optee-project>
> $ repo init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml
> $ repo sync -j4 --no-clone-bundle
> 
> # Get the toolchain
> $ cd <optee-project>/build
> $ make -j2 toolchains
> 
> # As trusted keys work is based on latest tpmdd/master, so we can
> change Linux base as follows:
> $ cd <optee-project>/linux
> $ git remote add tpmdd git://git.infradead.org/users/jjs/linux-tpmdd.git
> $ git pull tpmdd
> $ git checkout -b tpmdd-master remotes/tpmdd/master
> # Cherry-pick and apply TEE features patch-set from this PR[3]
> # Apply this Linux trusted keys patch-set.
> 
> # Now move on to build the source code
> $ cd <optee-project>/build
> # Apply attached "keyctl_change" patch
> $ patch -p1 < keyctl_change
> $ make -j`nproc`
> CFG_IN_TREE_EARLY_TAS=trusted_keys/f04a0fe7-1f5d-4b9b-abf7-619b85b4ce8c
> 
> # Run QEMU setup
> $ make run-only
> # Type "c" on QEMU console to continue boot
> 
> # Now there should be two virtual consoles up, one for OP-TEE and
> other for Linux
> # On Linux console, you can play with "keyctl" utility to have trusted
> and encrypted keys based on TEE.
> 
> Do let me know in case you are stuck while following the above steps.
> 
> [1] https://optee.readthedocs.io/en/latest/building/devices/qemu.html#qemu-v8
> [2] https://optee.readthedocs.io/en/latest/building/prerequisites.html#prerequisites
> [3] https://lkml.org/lkml/2020/5/4/1062
> 
> -Sumit

Thanks I'll try this out as soon as the v5.8 release hassle is over!

/Jarkko
