From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 23 Jul 2020 02:01:14 +0000
Subject: Re: [PATCH] encrypted-keys: Replace HTTP links with HTTPS ones
Message-Id: <20200723020114.GG45081@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200716195227.65839-1-grandmaster@al2klimov.de>
In-Reply-To: <20200716195227.65839-1-grandmaster@al2klimov.de>
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: zohar@linux.ibm.com, dhowells@redhat.com, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 09:52:27PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.

A commit message should describe action e.g. "Replace HTTP URL with
HTTPS URL given the security concerns and the slow deprecation of HTTP."

> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.

Please remove this. We don't care about it. Git log should only contain
information either for studying or maintaining the kernel source code.

> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

/Jarkko
