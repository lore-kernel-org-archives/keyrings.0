From: James Morris <jmorris@namei.org>
Date: Tue, 07 Aug 2018 20:10:31 +0000
Subject: Re: [RFCv3 07/13] KEYS: trusted: Expose common functionality
Message-Id: <alpine.LRH.2.21.1808080609040.6328@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180802183121.22909-8-denkenz@gmail.com>
In-Reply-To: <20180802183121.22909-8-denkenz@gmail.com>
To: keyrings@vger.kernel.org

On Thu, 2 Aug 2018, Denis Kenzior wrote:

> This patch exposes some common functionality needed to send TPM
> commands.  The current approach is a complete hack and needs to be
> addressed properly.  This commit just show-cases what functionality
> would need to be moved to a shared location or exposed in some other
> manner.

Consider adding the linux-integrity list to the cc line for these patches.



-- 
James Morris
<jmorris@namei.org>

