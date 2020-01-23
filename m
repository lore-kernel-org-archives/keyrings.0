From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 23 Jan 2020 12:55:52 +0000
Subject: Re: [PATCH v2 1/2] security/keys/secure_key: Adds the secure key support based on CAAM.
Message-Id: <88a1bb22a5f63ff81161f25220d47710420a81ac.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180723111432.26830-1-udit.agarwal@nxp.com>
         <ae70f48b-be78-ffb8-8b36-0d278b2e19f6@phytec.de>
In-Reply-To: <ae70f48b-be78-ffb8-8b36-0d278b2e19f6@phytec.de>
To: Maik Otto <m.otto@phytec.de>, Udit Agarwal <udit.agarwal@nxp.com>, dhowells@redhat.com, zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: sahil.malhotra@nxp.com, ruchika.gupta@nxp.com, horia.geanta@nxp.com, aymen.sghaier@nxp.com

On Fri, 2020-01-17 at 12:52 +0100, Maik Otto wrote:
> Hi
> 
> I tested both patches in combination with
> [RFC,2/2] dm-crypt: Use any key type which is registered from
> https://patchwork.kernel.org/patch/10835633/  with bug fix
> and  an i.MX6Quad (logged device) with Mainline Kernel 4.19.88
> 
> The following tests were successful:
> - key generation with CAAM
> keyctl add secure kmk-master "new 64" @s
> - export and import key blob with same controller
> keyctl pipe 332995568 > secure_key.blob
> reboot device
> keyctl add secure kmk-master "load `cat secure_key.blob`" @s
> - import keyblob with an other cpu and same keys for secure boot
> caam_jr 2102000.jr1: caam op done err: 20000c1a
> [ 185.788931] secure_key: key_blob decap fail (-22)
> add_key: Invalid argument
> => failing import was expected: pass
> - use key from keyring in dmcrypt with an sd-card
> dmsetup create test --table "0 106496 crypt aes-xts-plain64
> :64:secure:kmk-master 0 /dev/mmcblk0p3 0"
> write,read reboot and read again
> 
> Tested-by: Maik Otto<m.otto@phytec.de>

I cannot find the original patch. Can this patch set be
sent together with a cover letter, which is obviously
missing from the earlier version, please.

/Jarkko
