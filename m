From: Ben Boeckel <me@benboeckel.net>
Date: Wed, 13 May 2020 22:23:05 +0000
Subject: [PATCH 0/1] Clarify keyctl_set_reqkey_keyring(3) return value
Message-Id: <20200513222306.870160-1-list.lkml.keyrings@me.benboeckel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

From: Ben Boeckel <mathstuf@gmail.com>

Minor documentation fixup I noticed.

I'm still in the process of migrating emails for various usages hence
the email From mismatch here (I've migrated my list subscription, but
not my general contribution email).

Ben Boeckel (1):
  man: clarify that keyctl_set_reqkey_keyring(3) returns the old default

 man/keyctl_set_reqkey_keyring.3 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: 704802463dd1fd74000132d4325300c718a4b474
-- 
2.25.4
