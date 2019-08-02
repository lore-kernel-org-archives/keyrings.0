From: Tyler Hicks <tyhicks@canonical.com>
Date: Fri, 02 Aug 2019 14:27:22 +0000
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or deactivated
Message-Id: <20190802142721.GA26616@elm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
 <20190711194811.rfsohbfc3a7carpa@linux.intel.com>
 <b4454a78-1f1b-cc75-114a-99926e097b05@huawei.com>
 <20190801163215.mfkagoafkxscesne@linux.intel.com>
 <e50c4cfa-1f0c-6f4d-1910-010a8d874393@huawei.com>
In-Reply-To: <e50c4cfa-1f0c-6f4d-1910-010a8d874393@huawei.com>
To: Roberto Sassu <roberto.sassu@huawei.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: jejb@linux.ibm.com, zohar@linux.ibm.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com, nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com

On 2019-08-02 10:21:16, Roberto Sassu wrote:
> On 8/1/2019 6:32 PM, Jarkko Sakkinen wrote:
> > On Mon, Jul 15, 2019 at 06:44:28PM +0200, Roberto Sassu wrote:
> > > According to the bug report at https://bugs.archlinux.org/task/62678,
> > > the trusted module is a dependency of the ecryptfs module. We should
> > > load the trusted module even if the TPM is inactive or deactivated.
> > > 
> > > Given that commit 782779b60faa ("tpm: Actually fail on TPM errors during
> > > "get random"") changes the return code of tpm_get_random(), the patch
> > > should be modified to ignore the -EIO error. I will send a new version.
> > 
> > Do you have information where this dependency comes from?
> 
> ecryptfs retrieves the encryption key from encrypted keys (see
> ecryptfs_get_encrypted_key()).

That has been there for many years with any problems. It was added
in 2011:

 commit 1252cc3b232e582e887623dc5f70979418caaaa2
 Author: Roberto Sassu <roberto.sassu@polito.it>
 Date:   Mon Jun 27 13:45:45 2011 +0200

     eCryptfs: added support for the encrypted key type

What's recently changed the situation is this patch:

 commit 240730437deb213a58915830884e1a99045624dc
 Author: Roberto Sassu <roberto.sassu@huawei.com>
 Date:   Wed Feb 6 17:24:51 2019 +0100

     KEYS: trusted: explicitly use tpm_chip structure from tpm_default_chip()

Now eCryptfs has a hard dependency on a TPM chip that's working
as expected even if eCryptfs (or the rest of the system) isn't utilizing
the TPM. If the TPM behaves unexpectedly, you can't access your files.
We need to get this straightened out soon.

Tyler

> 
> Roberto
> 
> -- 
> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> Managing Director: Li Peng, Li Jian, Shi Yanli
