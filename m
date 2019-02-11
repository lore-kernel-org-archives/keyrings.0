From: Joe Perches <joe@perches.com>
Date: Mon, 11 Feb 2019 01:54:03 +0000
Subject: Re: [PATCH] MAINTAINERS: use tab instead of spaces
Message-Id: <7befaea3d1a86950f9dd270fed47072214fa2876.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190210181011.6117-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20190210181011.6117-1-lukas.bulwahn@gmail.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, James Bottomley <jejb@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linuxibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 2019-02-10 at 19:10 +0100, Lukas Bulwahn wrote:
> Mimi Zohar used spaces instead of a tab when adding Jarkko Sakkinen as
> further maintainer to the KEYS-TRUSTED section entry. So, we rectify this
> with this commit.
> 
> The issue was detected when writing a script that parses MAINTAINERS.

checkpatch already does that btw:

$ ./scripts/checkpatch.pl -f MAINTAINERS
WARNING: MAINTAINERS entries use one tab after TYPE:
#8408: FILE: MAINTAINERS:8408:
+M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

WARNING: MAINTAINERS entries use one tab after TYPE:
#12607: FILE: MAINTAINERS:12607:
+M:  Ilia Lin <ilia.lin@gmail.com>

WARNING: MAINTAINERS entries use one tab after TYPE:
#12608: FILE: MAINTAINERS:12608:
+L:  linux-pm@vger.kernel.org

WARNING: MAINTAINERS entries use one tab after TYPE:
#12609: FILE: MAINTAINERS:12609:
+S:  Maintained

WARNING: MAINTAINERS entries use one tab after TYPE:
#12610: FILE: MAINTAINERS:12610:
+F:  Documentation/devicetree/bindings/opp/kryo-cpufreq.txt

WARNING: MAINTAINERS entries use one tab after TYPE:
#12611: FILE: MAINTAINERS:12611:
+F:  drivers/cpufreq/qcom-cpufreq-kryo.c

total: 0 errors, 6 warnings, 16993 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace
