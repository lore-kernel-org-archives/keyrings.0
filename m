From: Ben Boeckel <me@benboeckel.net>
Date: Sat, 16 May 2020 00:23:33 +0000
Subject: [PATCH 0/1] Fix mention of comma-separated pkey query strings
Message-Id: <20200516002334.2025760-1-list.lkml.keyrings@me.benboeckel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

From: Ben Boeckel <mathstuf@gmail.com>

I'm not sure where this comes from, but the code in the library and the
kernel only supports space- and tab-separated parameters.

Ben Boeckel (1):
  man: the info strings are actually space or tab separated

 man/keyctl_pkey_encrypt.3 | 4 ++--
 man/keyctl_pkey_query.3   | 2 +-
 man/keyctl_pkey_sign.3    | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)


base-commit: 704802463dd1fd74000132d4325300c718a4b474
-- 
2.25.4
