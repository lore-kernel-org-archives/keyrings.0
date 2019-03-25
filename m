From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 25 Mar 2019 14:50:32 +0000
Subject: Re: [PATCH] security/keys/trusted: Allow operation without hardware TPM
Message-Id: <20190325145032.GA29989@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155295271345.1945351.6465460744078693578.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190321135451.GD4603@linux.intel.com>
 <809e827b-fdbe-fbb8-8acf-2878ae9f7777@huawei.com>
 <CAPcyv4gc_KWedC12bTcX24KwjKiBCF=yvouRNzCbJKaLrgJdDg@mail.gmail.com>
 <d0434a90-4010-8c76-c02e-bb1a6ec831ef@huawei.com>
 <20190322101227.GB3122@linux.intel.com>
 <CAPcyv4g=W9Fc=nfYjXG9-mpzn2cfiYEz4J7ksP3ziFUc_5k1OQ@mail.gmail.com>
 <20190325141223.GA13766@linux.intel.com>
In-Reply-To: <20190325141223.GA13766@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, James Bottomley <jejb@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org

On Mon, Mar 25, 2019 at 04:12:23PM +0200, Jarkko Sakkinen wrote:
> > Robert, please feel free to re-author the proposed patch however you
> > see fit, I just want whatever will get libnvdimm operational again in
> > the shortest amount of time.
> 
> I've decided go with a patch of least innovation i.e. one that simply reverts
> the old behavior. Sending patch soon.

I.e. https://www.lkml.org/lkml/2019/3/25/674

I think fixing the actual dependency issue would be unorthodox at this
point of release cycle as adding dependencies was not the root cause
for the bug even if existing somewhat unorthodox were. Better to just
the problem by reverting the semantics near the same as in v5.0 and
take this dependency discussion "offline" for the release work...

/Jarkko
