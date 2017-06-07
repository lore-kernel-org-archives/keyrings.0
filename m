From: Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
Date: Wed, 07 Jun 2017 18:07:35 +0000
Subject: Re: [PATCH keyutils] TEST: Add KDF leading zero test
Message-Id: <6557205.f69LNu3Mmd@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170607173135.19912-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20170607173135.19912-1-mathew.j.martineau@linux.intel.com>
To: keyrings@vger.kernel.org

Am Mittwoch, 7. Juni 2017, 19:31:35 CEST schrieb Mat Martineau:

Hi Mat,

> Diffie-Hellman results used as input to a KDF algorithm can have leading
> zero bytes, and the current kernel DH implementation truncates leading
> zero bytes. This test confirms that the KDF code correctly handles DH
> results with leading zeros.

Thank you for the test.

May I ask where you got the vector from?

Ciao
Stephan
