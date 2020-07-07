From: James Morris <jmorris@namei.org>
Date: Tue, 07 Jul 2020 20:28:31 +0000
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: security
Message-Id: <alpine.LRH.2.21.2007080628020.1849@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200705214512.28498-1-grandmaster@al2klimov.de>
In-Reply-To: <20200705214512.28498-1-grandmaster@al2klimov.de>
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: serge@hallyn.com, john.johansen@canonical.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org

On Sun, 5 Jul 2020, Alexander A. Klimov wrote:

> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Thanks.

Applied to 
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


-- 
James Morris
<jmorris@namei.org>
