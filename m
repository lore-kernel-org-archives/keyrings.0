From: Eric Biggers <ebiggers3@gmail.com>
Date: Thu, 21 Sep 2017 20:57:39 +0000
Subject: [PATCH v2 0/3] KEYS: fix error handling in request_key_auth_new()
Message-Id: <20170921205742.144596-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Fix a reference leak and a NULL pointer dereference in the error
handling paths of request_key_auth_new().

Eric Biggers (3):
  KEYS: fix cred refcount leak in request_key_auth_new()
  KEYS: don't revoke uninstantiated key in request_key_auth_new()
  KEYS: use kmemdup() in request_key_auth_new()

 security/keys/request_key_auth.c | 73 ++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 41 deletions(-)

-- 
2.14.1.821.g8fa685d3b7-goog

