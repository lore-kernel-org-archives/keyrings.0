From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Mon, 22 Oct 2018 10:43:36 +0000
Subject: [PATCH v2 0/4] update sign-file to use generic engine code
Message-Id: <1540205016.2815.7.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

This patch does both built in engines and explicitly specified ones as
per the discussion we had on the "support other engines" patch.

I think this should satisfy everyone's use case without requiring any
change to the current work flow (or even options people use to build
and sign modules).

James

---

James Bottomley (4):
  sign-file: stop referring to the code as main.c
  sign-file: remove open coding of ERR_clear_error()
  sign-file: add generic built-in engine key support
  sign-file: add explicit engine specification

 scripts/sign-file.c | 90 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 28 deletions(-)

-- 
2.16.4
